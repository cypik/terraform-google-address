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
  environment  = "test"
  region       = "asia-northeast1"
  address_type = "EXTERNAL"
  name = [
  "regional-external-ip-address-1"]
}