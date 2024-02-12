provider "google" {
  project = "local-concord-408802"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

locals {
  domain       = "justfortestingmultinames-${random_string.suffix.result}.local"
  forward_zone = "forward-example-multinames"
}

#####==============================================================================
##### address module call.
#####==============================================================================
module "address" {
  source           = "../../"
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