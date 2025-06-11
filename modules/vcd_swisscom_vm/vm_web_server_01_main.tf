#=================================================================================================================================
# This sample terraform script shows how terraform can be used to write infrastructure as code in ESC with Cloud Director.
# This is a basic example to create three VCD custom (swisscom) vms (web,app and db) and attach them to their respective networks.
# Check out this link https://www.terraform.io/docs/providers/vcd/index.html for extensive list of supported VCD resources.
#=================================================================================================================================

// Generate request payload for custom swisscom VM from template json
data "template_file" "web_server_01_json" {
  template = file("${path.module}/schemas/swisscom_vm.json.tpl")

  vars = {
    description = "web-server-01",
    serviceLevel = "Basic",
    location = "olt",
    locationConstraint = "wss-olt-rhel",
    storagePolicy = "wss-olt-eco",
    templateHref = var.vcd_template_vm_href,
    password = var.vm_root_password,
    userUrn = data.vcd_org_user.org-user.id,
    userName = data.vcd_org_user.org-user.name,
    vdcId = replace(data.vcd_org_vdc.aat-101-vdc.id, "urn:vcloud:vdc:", ""),
    vdcName = data.vcd_org_vdc.aat-101-vdc.name,
    orgName = data.vcd_org.aat-101-org.name,
    orgId = replace(data.vcd_org.aat-101-org.id, "urn:vcloud:org:", ""),
    network = "aat-101-web-servers-network"
  }
}

// VCD Custom (Swisscom) VM - VCD runtime defined entity 
resource "vcd_rde" "web_server_01_rde" {
  org          = var.vcd_org
  name         = "swisscom-vm-01"
  rde_type_id  = data.vcd_rde_type.swisscom_rde_type.id
  resolve      = false
  input_entity = data.template_file.web_server_01_json.rendered

  lifecycle {
    ignore_changes = all
  }
}

output "web_server_01_rde_id" {
  value = vcd_rde.web_server_01_rde.id
}

# A null_resource in Terraform is a special resource that does not create any infrastructure but allows you to execute provisioners, and local scripts.
# In this example, we execute a shell command to make API calls to VCD to wait for the RDE to be RESOLVED (RDE will be set to resolved when VM creation is completed and when the VM is ready)
resource "null_resource" "wait_for_web_server_01" {
  provisioner "local-exec" {
    quiet = true
    
    command = <<EOT
    # Send VCD POST API request to get session token using OAuth2 API token
    vcd_session_token_response=$(curl -s --request POST 'https://${var.vcd_api_host}/oauth/tenant/${var.vcd_org}/token' \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=refresh_token' \
    --data-urlencode 'refresh_token=${var.vcd_api_token}')

    # Check if curl command was successful
    if [ $? -eq 0 ]; then
      echo "VCD Get Session Token successful."

      # Use jq to to get the access token
      access_token=$(echo "$vcd_session_token_response" | jq -r '.access_token')

      # echo "Access Token is: $access_token"

      # Wait in 30 seconds loop upto 60 minutes (120 times x 30 seconds), for the vm rde state to become RESOLVED
      for i in $(seq 1 120); do
        # Send GET request to fetch swisscom vm rde instance
        swisscom_vm_rde_response=$(curl -s --request GET 'https://${var.vcd_api_host}/cloudapi/1.0.0/entities/${vcd_rde.web_server_01_rde.id}' \
        --header "Accept: application/*;version=${var.vcd_api_version}" \
        --header "Authorization: Bearer $access_token")
        
        # echo "swisscom_vm_rde_response is:" $swisscom_vm_rde_response
        # Check if the vm rde state is RESOLVED
        if [ $(echo "$swisscom_vm_rde_response" | jq -r '.state') = "RESOLVED" ]; then
            echo "VM is ready!"
            
            swisscom_vm_rde_state=$(echo "$swisscom_vm_rde_response" | jq -r '.state')
            echo "Swisscom VM RDE State: $swisscom_vm_rde_state"

            swisscom_vm_name=$(echo "$swisscom_vm_rde_response" | jq -r '.name')
            echo "Swisscom VM Name: $swisscom_vm_name"

            # save vm name in temporary local file to keep the generated VM name, it's not possible to access the vairables set in the local-exec command out side in the terraform resources or data sources
            echo "$swisscom_vm_name" > "file_web_server_01_vm_name.txt"
            
            break   
        else
            swisscom_vm_rde_state=$(echo "$swisscom_vm_rde_response" | jq -r '.state')
            echo "Swisscom VM RDE State: $swisscom_vm_rde_state"
            
            echo "[Attempts remaining: $((120 - $i))] Waiting for VM to be created..."
            sleep 30
        fi
      done  
    else
      echo "Failed to retrieve VCD session token"
    fi
    EOT
  }
  depends_on = [vcd_rde.web_server_01_rde]
}

// Read the value (generated vm name) from the file
data "local_file" "web_server_01_vm_name_file" {
  filename   = "file_web_server_01_vm_name.txt"
  depends_on = [null_resource.wait_for_web_server_01]
}

#============================
# The vcd_resource_list will crate a tf file with the needed import blocks to import the created VM into terraform state
# by importing created vcd vm into terraform state provides the ability to manage the vm from terraform
#============================
data "vcd_resource_list" "import_web_server_01_vm" {
  resource_type    = "vcd_vm"
  name             =  "${chomp(data.local_file.web_server_01_vm_name_file.content)}"
  vdc = var.vcd_vdc
  name_regex = "(${chomp(data.local_file.web_server_01_vm_name_file.content)})"
  list_mode        = "import"
  import_file_name = "vm_web_server_01_import.tf"
}