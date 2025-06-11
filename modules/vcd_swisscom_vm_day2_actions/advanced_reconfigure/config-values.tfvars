#==========================================================================================================================================
# This file holds values that are assigned to the variables, which will be referenced in terraform scripts.
# The following command shows how this file can be used while applying terraform plan.
# sample command : terraform apply -var-file="config-values.tfvars"
#==========================================================================================================================================

vcd_org = "aat-101-aat-101" // Organization name

vcd_url = "https://api.sci01.test.private.cloud.swisscom.ch/api" // VCD URL, Example : https://api.sci01.private.cloud.swisscom.ch/api

vcd_api_token = "<VCD API Token>" // VCD API Token for the user, check out this article on how to generate API token: https://blogs.vmware.com/cloudprovider/2022/03/cloud-director-api-token.html

vcd_vdc = "aat-101-aat-101" // Virtual Data Center name