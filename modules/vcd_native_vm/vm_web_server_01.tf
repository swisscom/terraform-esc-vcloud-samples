#=================================================================================================================================
# This sample terraform script shows how terraform can be used to write infrastructure as code in ESC with Cloud Director.
# This is very basic example to create three VCD native vms (web,app and db) and attach them to their respective networks.
# Check out this link https://www.terraform.io/docs/providers/vcd/index.html for extensive list of supported VCD resources.
#=================================================================================================================================

# VCD Native VM for web server
resource "vcd_vm" "aat-101-web-01" {
  name 						    = "web-server-01" // VM name
  computer_name       = "web-server-01" // Host name
  vapp_template_id 		= data.vcd_catalog_vapp_template.swisscom-rhel-9-template.id
  memory					    = 2048 // Momory in MBs
  cpus						    = 2 // Number of vCPUs

  power_on 					  = "true"

  // TODO Guest Password

  placement_policy_id = data.vcd_vm_placement_policy.placement-policy.id
  storage_profile = var.vcd_storage_policy

  network {
    type					= "org"
    name					= "aat-101-web-servers-network"
    ip_allocation_mode		= "POOL"
    is_primary         = true
  }

  accept_all_eulas 			= "true"
}

# Adding additional disk to the VM
resource "vcd_vm_internal_disk" "aat-101-web-01-disk1" {
  vapp_name  = vcd_vm.aat-101-web-01.vapp_name
  vm_name    = vcd_vm.aat-101-web-01.name
  bus_type = "paravirtual"
  size_in_mb = "10240"
  bus_number = 0
  unit_number = 1
  storage_profile = var.vcd_storage_policy
  depends_on      = [vcd_vm.aat-101-web-01]
}