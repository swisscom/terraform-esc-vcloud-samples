#========================================================================================================
# In this terraform file, we define all needed variables, these are referenced in terraform scripts.
#========================================================================================================

variable "vcd_url" {
  description = "VCD Url"
}

variable "vcd_org" {
  description = "Contract Id / PRO-Number"
}

variable "vcd_api_token" {
  description = "VCD API Token"
}