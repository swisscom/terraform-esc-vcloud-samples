// Terraform data source for Organization
data "vcd_org" "aat-101-org" {
  name = var.vcd_org
}

// Terraform data source for org user
data "vcd_org_user" "org-user" {
  org  = var.vcd_org
  name = "adm1-taashud1@sccloudinfra.net"
}

// Terraform data source for rde type
data "vcd_rde_type" "rde_type" {
  vendor  = local.rde_type_vendor
  nss     = local.rde_type_nss
  version = local.rde_type_version
}

// Terraform data source for rde interface
data "vcd_rde_interface" "rde_interface" {
  vendor  = local.rde_type_vendor
  nss     = local.rde_day2_action_advanced_reconfigure_nss
  version = local.rde_day2_action_version
}