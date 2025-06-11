# need to specify on a module level, that the provider we are using is vmware/vcd, not hashicorp/vcd
terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
    }
  }

  # to allow the script to be run from every local machine and from a CI/CD, keep the state in S3 storage
  # the access and secret keys are provided as env variables: "AWS_ACCESS_KEY_ID" and "AWS_SECRET_ACCESS_KEY"
  # do not pay attention to the "aws" part, terraform naturally supports AWS S3
  # but also possible to specify custom endpoint
  /*
  backend "s3" {
    key                         = "terraform.tfstate"
    endpoint                    = "https://ds11s3.swisscom.com"
    bucket                      = "terraform-tests"
    region                      = ""
    skip_region_validation      = true
    skip_credentials_validation = true
  }
  */
}

provider "vcd" {
  auth_type = "api_token"
  api_token = var.vcd_api_token
  org = var.vcd_org
  url = var.vcd_url

  max_retry_timeout = "45" // Retry time for api
  allow_unverified_ssl = "true"
}
