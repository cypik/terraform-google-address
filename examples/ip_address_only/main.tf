provider "google" {
  project = "local-concord-408802"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### module-vpc
#####==============================================================================
module "vpc" {
  source                                    = "cypik/vpc/google"
  version                                   = "1.0.1"
  name                                      = "app"
  environment                               = "test"
  routing_mode                              = "REGIONAL"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

#####==============================================================================
##### module-subnetwork
#####==============================================================================
module "subnet" {
  source             = "cypik/subnet/google"
  version            = "1.0.1"
  name               = "app"
  environment        = "test"
  subnet_names       = ["subnet-a"]
  gcp_region         = "asia-northeast1"
  network            = module.vpc.vpc_id
  ip_cidr_range      = ["10.10.1.0/24"]
  address_enabled    = false
  route_enabled      = false
  router_enabled     = false
  router_nat_enabled = false
}

#####==============================================================================
##### address module call.
#####==============================================================================
module "address" {
  source      = "../../../../cypiknew/terraform-google-dns"
  ip_count    = 1
  name        = ["test"]
  environment = "app"
  region      = "asia-northeast1"
  subnetwork  = module.subnet.subnet_id
}