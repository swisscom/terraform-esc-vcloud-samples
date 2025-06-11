#========================================================================================================
# In this terraform file, we define all needed variables, these are referenced in terraform scripts.
#========================================================================================================

variable "vcd_url" {
  description = "VCD Url"
}

variable "vcd_org" {
  description = "Organization name"
}

variable "vcd_vdc" {
  description = "Virtual Data Center name"
}

variable "vcd_api_token" {
  description = "VCD API Token"
}

variable "vcd_catalog" {
  description = "Catalog name"
}

variable "vcd_template" {
  description = "vApp template name"
}

variable "vcd_storage_policy" {
  description = "Storage policy name"
}