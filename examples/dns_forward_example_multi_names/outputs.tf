output "addresses" {
  description = "List of address values managed by this module (e.g. [\"1.2.3.4\"])"
  value       = module.address.addresses
}

output "names" {
  description = "List of address resource names managed by this module (e.g. [\"gusw1-dev-fooapp-fe-0001-a-0001-ip\"])"
  value       = module.address.names
}

output "dns_fqdns" {
  description = "List of DNS fully qualified domain names registered in Cloud DNS.  (e.g. [\"gusw1-dev-fooapp-fe-0001-a-001.example.com\", \"gusw1-dev-fooapp-fe-0001-a-0002.example.com\"])"
  value       = module.address.dns_fqdns
}

output "forward_zone" {
  description = "The GCP name of the forward lookup DNS zone being used"
  value       = google_dns_managed_zone.forward.name
}

output "self_links" {
  description = "List of URIs of the created address resources"
  value       = module.address.self_links
}