#=================================================================================================================================
# This sample terraform script shows how terraform can be used to write infrastructure as code in ESC with Cloud Director.
# This is a basic example to create three VCD custom (swisscom) vms (web,app and db) and attach them to their respective networks.
# Check out this link https://www.terraform.io/docs/providers/vcd/index.html for extensive list of supported VCD resources.
#=================================================================================================================================

// Terraform data source for Organization
data "vcd_org" "aat-101-org" {
  name = var.vcd_org
}

// Terraform data source for virtual data center
data "vcd_org_vdc" "aat-101-vdc" {
  org  = var.vcd_org
  name = var.vcd_vdc
}

// Terraform data source for org user
data "vcd_org_user" "org-user" {
  org  = var.vcd_org
  name = "adm1-taashud1@sccloudinfra.net"
}

// Terraform data source for runtime defined entity type (type: Swisscom VM)
data "vcd_rde_type" "swisscom_rde_type" {
  vendor  = local.rde_type_vendor
  nss     = local.rde_type_nss
  version = local.rde_type_version
}