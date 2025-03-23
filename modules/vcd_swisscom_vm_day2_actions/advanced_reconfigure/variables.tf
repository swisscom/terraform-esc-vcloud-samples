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

variable "vcd_org" {
  description = "Organization"
}

variable "vcd_vdc" {
  description = "Virtual Data Center"
}

variable "vcd_api_token" {
  description = "VCD API Token"
}

variable "vcd_adv_reconfigure_rde_behavior_id" {
  description = "Advance Reconfigure RDE behavior id"
  default = "urn:vcloud:behavior-interface:VcdAdvancedReconfigure:swisscom:VcdAdvancedReconfigure:2.0.0"
}