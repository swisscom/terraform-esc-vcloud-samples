// Terraform data source for catalog
data "vcd_catalog" "compute-services-catalog" {
  org  = "admin-iaas"
  name = var.vcd_catalog
}

// Terraform data source for template
data "vcd_catalog_vapp_template" "swisscom-rhel-9-template" {
  org        = var.vcd_org
  catalog_id = data.vcd_catalog.compute-services-catalog.id
  name       = var.vcd_template
}

// Terraform data source for virtual data center
data "vcd_org_vdc" "aat-101-vdc" {
  org  = var.vcd_org
  name = var.vcd_vdc
}

// Terraform data source for placement policy/location
data "vcd_vm_placement_policy" "placement-policy" {
  name = "wms-olt-rhel" // Example: Multi-site olten location for rhel vms
  vdc_id = data.vcd_org_vdc.aat-101-vdc.id
}