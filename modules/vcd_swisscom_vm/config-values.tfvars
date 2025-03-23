#==========================================================================================================================================
# This file holds values that are assigned to the variables, which will be referenced in terraform scripts.
# The following command shows how this file can be used while applying terraform plan.
# sample command : terraform apply -var-file="config-values.tfvars"
#==========================================================================================================================================

vcd_org = "aat-101-aat-101" // Organization name

vcd_url = "https://api.sci01.test.private.cloud.swisscom.ch/api" // VCD URL, Example : https://api.sci01.private.cloud.swisscom.ch/api

vcd_api_token = "<VCD API Token>" // VCD API Token for the user, check out this article on how to generate API token: https://blogs.vmware.com/cloudprovider/2022/03/cloud-director-api-token.html

vcd_vdc = "aat-101-aat-101" // Virtual Data Center name

vcd_api_host = "api.sci01.test.private.cloud.swisscom.ch" // VCD Host, Example : api.sci01.private.cloud.swisscom.ch

vcd_api_version = "39.0" // VCD API Version, 39.0 is API version for VCD 10.6.1

vcd_catalog = "Compute Services" // Catalog name, "Compute Services" is where you can find Swisscom enterprise OS templates.

vm_root_password = "Swisscom.01" // VM Root/Administrator Password

vcd_template_vm_href = "https://api.sci01.test.private.cloud.swisscom.ch/api/vAppTemplate/vm-4378b2d4-a729-4039-821b-9ca817c06f86" // VCD vApp Template VM Href, can be found in VCD