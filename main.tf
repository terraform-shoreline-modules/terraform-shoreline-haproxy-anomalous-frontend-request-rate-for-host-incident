terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "anomalous_frontend_request_rate_for_haproxy" {
  source    = "./modules/anomalous_frontend_request_rate_for_haproxy"

  providers = {
    shoreline = shoreline
  }
}