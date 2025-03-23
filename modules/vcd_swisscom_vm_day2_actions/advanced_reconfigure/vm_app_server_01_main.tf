#=================================================================================================================================
# This sample terraform script shows how terraform can be used to write infrastructure as code in ESC with Cloud Director.
# This is a basic example to invoke VCD custom day2 actions like advanced reconfigure, change backup policy etc.
# Check out this link https://www.terraform.io/docs/providers/vcd/index.html for extensive list of supported VCD resources.
#=================================================================================================================================

// Terraform data source for vcd vm
data "vcd_vm" "app_server_01_vm" {
  name = "AAT10110276"
  vdc = var.vcd_vdc
}

// Generate request payload for invoking advanced reconfigure day2 action from template json
data "template_file" "app_server_01_adv_reconfigure_json" {
  template = file("${path.module}/schemas/advanced_reconfigure_json.tpl")

  vars = {
    vmId = data.vcd_vm.app_server_01_vm.id,
    serviceLevel = "Standard",
    location  = "zhh",
    locationConstraint  = "wss-zhh-rhel",
    storagePolicy = "wss-zhh-eco",
    userUrn  = data.vcd_org_user.org-user.id,
    orgUrn  = data.vcd_org.aat-101-org.id
  }
}

// Terraform data source for vcd rde
data "vcd_rde" "app_server_01_rde" {
  rde_type_id = data.vcd_rde_type.rde_type.id
  name        = "AAT10110276"
}

// Terraform data source for vcd rde
data "vcd_rde_behavior_invocation" "invoke_advance_reconfigure_app_01" {
  rde_id         = data.vcd_rde.app_server_01_rde.id
  behavior_id    = var.vcd_adv_reconfigure_rde_behavior_id
  arguments_json = data.template_file.app_server_01_adv_reconfigure_json.rendered
  invoke_on_refresh = true
}