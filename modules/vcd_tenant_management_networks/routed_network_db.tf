#=================================================================================================================================
# This sample terraform script shows how terraform can be used to write infrastructure as code in ESC with Cloud Director.
# This is a basic example to manage routed networks.
# Check out this link https://www.terraform.io/docs/providers/vcd/index.html for extensive list of supported VCD resources.
#=================================================================================================================================

// Terraform data source for data center group
data "vcd_vdc_group" "aat-101-db-servers-egw" {
  name = "aat-101-db-servers-egw"
}

// Terraform data source for edge gateway
data "vcd_nsxt_edgegateway" "aat-101-db-servers-egw" {
  org      = var.vcd_org
  owner_id = data.vcd_vdc_group.aat-101-db-servers-egw.id
  name     = "aat-101-db-servers-egw"
}

// Network for DB servers
resource "vcd_network_routed_v2" "aat-101-db-servers-network" {
  org         = var.vcd_org
  name        = "aat-101-db-servers-network"
  description = "My routed network for db servers"

  route_advertisement_enabled = true

  edge_gateway_id = data.vcd_nsxt_edgegateway.aat-101-db-servers-egw.id

  gateway            = "10.20.30.129"
  prefix_length      = 26

  static_ip_pool {
    start_address = "10.20.30.131"
    end_address   = "10.20.30.191"
  }
}  

// Configure DHCP
resource "vcd_nsxt_network_dhcp" "aat-101-db-servers-network-dhcp" {
  org = var.vcd_org
  
  org_network_id      = vcd_network_routed_v2.aat-101-db-servers-network.id
  mode                = "NETWORK"
  listener_ip_address = "10.20.30.130"
}