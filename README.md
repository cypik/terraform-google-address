# Terraform-google-address
# Terraform Google Cloud Address Module
## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [License](#license)
- [Author](#author)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This project deploys a Google Cloud infrastructure using Terraform to create address .
## Usage
To get started, make sure you have configured your GCP provider. You can use the following code as a starting point:
### Examples

## Example: global_external_address
```hcl
module "address" {
  source       = "cypik/address/google"
  version      = "1.0.0"
  ip_count     = 1
  name         = ["app"]
  environment  = "test"
  region       = "asia-northeast1"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}
```

## Example: regional_external_address
```hcl
module "address" {
  source       = "cypik/address/google"
  version      = "1.0.0"
  ip_count     = 1
  name         = ["regional-external-ip-address-1"]
  environment  = "test"
  region       = "asia-northeast1"
  address_type = "EXTERNAL"

}
```

## Example: internal_with_dynamic_ip
```hcl
module "address" {
  source      = "cypik/address/google"
  version     = "1.0.0"
  ip_count    = 1
  name        = ["internal-address1"]
  environment = "app"
  region      = "asia-northeast1"
  subnetwork  = module.subnet.subnet_id
}
```

## Example: internal_with_specific_ip
```hcl
module "address" {
  source      = "cypik/address/google"
  version     = "1.0.0"
  ip_count    = 2
  name        = ["internal-address1"]
  environment = "app"
  region      = "asia-northeast1"
  subnetwork  = module.subnet.subnet_id
  addresses   = ["10.10.1.2", "10.10.1.3"]
}
```

## Example: ip_address_only
```hcl
module "address" {
  source      = "cypik/address/google"
  version     = "1.0.0"
  ip_count    = 1
  name        = ["test"]
  environment = "app"
  region      = "asia-northeast1"
  subnetwork  = module.subnet.subnet_id
}
```

## Example: dns_forward_example_multi_names
```hcl
module "address" {
  source           = "cypik/address/google"
  version          = "1.0.0"
  name             = ["test"]
  environment      = "app"
  region           = "asia-northeast1"
  enable_cloud_dns = true
  dns_domain       = local.domain
  dns_managed_zone = google_dns_managed_zone.forward.name

  dns_short_names = [
    "testip-041",
    "testip-042",
    "testip-043",
  ]
  address_type = "EXTERNAL"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_dns_managed_zone" "forward" {
  name          = local.forward_zone
  dns_name      = "${local.domain}."
  description   = "DNS forward lookup zone example"
  force_destroy = true
  project       = "local-concord-408802"
}
```

You can customize the input variables according to your specific requirements.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/cypik/terraform-google-address/tree/master/examples) directory within this repository.

## Author
Your Name Replace **MIT** and **Cypik** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the **MIT** License - see the [LICENSE](https://github.com/cypik/terraform-google-address/blob/master/LICENSE) file for details.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.50, < 5.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.50, < 5.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cypik/labels/google | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_global_address.global_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_dns_record_set.ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.ptr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | The type of address to reserve, either "INTERNAL" or "EXTERNAL". If unspecified, defaults to "INTERNAL". | `string` | `""` | no |
| <a name="input_addresses"></a> [addresses](#input\_addresses) | A list of IP addresses to create.  GCP will reserve unreserved addresses if given the value "".  If multiple names are given the default value is sufficient to have multiple addresses automatically picked for each name. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | The domain to append to DNS short names when registering in Cloud DNS. | `string` | `""` | no |
| <a name="input_dns_managed_zone"></a> [dns\_managed\_zone](#input\_dns\_managed\_zone) | The name of the managed zone to create records within.  This managed zone must exist in the host project. | `string` | `""` | no |
| <a name="input_dns_record_type"></a> [dns\_record\_type](#input\_dns\_record\_type) | The type of records to create in the managed zone.  (e.g. "A") | `string` | `"A"` | no |
| <a name="input_dns_reverse_zone"></a> [dns\_reverse\_zone](#input\_dns\_reverse\_zone) | The name of the managed zone to create PTR records within.  This managed zone must exist in the host project. | `string` | `""` | no |
| <a name="input_dns_short_names"></a> [dns\_short\_names](#input\_dns\_short\_names) | A list of DNS short names to register within Cloud DNS.  Names corresponding to addresses must align by their list index position in the two input variables, `names` and `dns_short_names`.  If an empty list, no domain names are registered.  Multiple names may be registered to the same address by passing a single element list to names and multiple elements to dns\_short\_names.  (e.g. ["gusw1-dev-fooapp-fe-0001-a-001"]) | `list(string)` | `[]` | no |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | The DNS TTL in seconds for records created in Cloud DNS.  The default value should be used unless the application demands special handling. | `number` | `300` | no |
| <a name="input_enable_cloud_dns"></a> [enable\_cloud\_dns](#input\_enable\_cloud\_dns) | If a value is set, register records in Cloud DNS. | `bool` | `false` | no |
| <a name="input_enable_reverse_dns"></a> [enable\_reverse\_dns](#input\_enable\_reverse\_dns) | If a value is set, register reverse DNS PTR records in Cloud DNS in the managed zone specified by dns\_reverse\_zone | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_global"></a> [global](#input\_global) | The scope in which the address should live. If set to true, the IP address will be globally scoped. Defaults to false, i.e. regionally scoped. When set to true, do not provide a subnetwork. | `bool` | `false` | no |
| <a name="input_ip_count"></a> [ip\_count](#input\_ip\_count) | The number of IP addresses to create/manage. | `number` | `1` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | The IP Version that will be used by this address. | `string` | `"IPV4"` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'cypik'. | `string` | `"cypik"` | no |
| <a name="input_name"></a> [name](#input\_name) | A list of IP address resource names to create.  This is the GCP resource name and not the associated hostname of the IP address.  Existing resource names may be found with `gcloud compute addresses list` (e.g. ["gusw1-dev-fooapp-fe-0001-a-001-ip"]) | `list(string)` | `[]` | no |
| <a name="input_network_tier"></a> [network\_tier](#input\_network\_tier) | The networking tier used for configuring this address. | `string` | `"PREMIUM"` | no |
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | The prefix length of the IP range. | `number` | `16` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The purpose of the resource(GCE\_ENDPOINT, SHARED\_LOADBALANCER\_VIP, VPC\_PEERING). | `string` | `"GCE_ENDPOINT"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to create the address in | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/cypik/terraform-google-address"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnet containing the address.  For EXTERNAL addresses use the empty string, "".  (e.g. "projects/<project-name>/regions/<region-name>/subnetworks/<subnetwork-name>") | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addresses"></a> [addresses](#output\_addresses) | List of address values managed by this module (e.g. ["1.2.3.4"]) |
| <a name="output_dns_fqdns"></a> [dns\_fqdns](#output\_dns\_fqdns) | List of DNS fully qualified domain names registered in Cloud DNS.  (e.g. ["gusw1-dev-fooapp-fe-0001-a-001.example.com", "gusw1-dev-fooapp-fe-0001-a-0002.example.com"]) |
| <a name="output_names"></a> [names](#output\_names) | List of address resource names managed by this module (e.g. ["gusw1-dev-fooapp-fe-0001-a-0001-ip"]) |
| <a name="output_reverse_dns_fqdns"></a> [reverse\_dns\_fqdns](#output\_reverse\_dns\_fqdns) | List of reverse DNS PTR records registered in Cloud DNS.  (e.g. ["1.2.11.10.in-addr.arpa", "2.2.11.10.in-addr.arpa"]) |
| <a name="output_self_links"></a> [self\_links](#output\_self\_links) | List of URIs of the created address resources |
<!-- END_TF_DOCS -->