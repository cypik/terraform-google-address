provider "google" {
  project = "local-concord-408802"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### address module call.
#####==============================================================================
module "address" {
  source       = "../../"
  ip_count     = 1
  region       = "asia-northeast1"
  name         = ["app"]
  environment  = "test"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}