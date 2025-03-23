#========================================================================================================
# In this terraform file, we define all needed variables, these are referenced in terraform scripts.
#========================================================================================================

// constants for custom vcd vm (swisscom vm)
locals {
  rde_type_vendor  = "swisscom"
  rde_type_nss     = "vm"
  rde_type_version = "1.0.0"
}

variable "vcd_url" {
  description = "VCD Url"
}

variable "vcd_api_host" {
  description = "VCD Host for API calls"
}

variable "vcd_org" {
  description = "Organization"
}

variable "vcd_vdc" {
  description = "Virtual Data Center"
}

variable "vcd_api_token" {
  description = "VCD API Token"
}

variable "vcd_api_version" {
  description = "VCD API Version"
}

variable "vm_root_password" {
  description = "Root Password for the VM"
}

variable "vcd_catalog" {
  description = "Catalog name"
}

variable "vcd_template_vm_href" {
  description = "vApp Template VM Href"
}