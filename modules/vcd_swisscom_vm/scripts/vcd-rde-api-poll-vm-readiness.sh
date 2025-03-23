#!/bin/bash
# Script to use VCD API to query and wait for the VM(RDE) status to become RESOLVED 
# Send POST request to get VCD session token
# e.g. https://sci01.test.private.cloud.swisscom.ch/oauth/tenant/aat-101-iaas-terraform-tests/token
vcd_session_token_response=$(curl --request POST 'https://{{vcd_host}}/oauth/tenant/{{vcd_org_name}}/token' \
--header 'Accept: application/json' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=refresh_token' \
--data-urlencode 'refresh_token=<outh_token>')

# Check if curl command was successful
if [ $? -eq 0 ]; then
  echo "VCD Get Session Token successful."

  # Use jq to to get the access token
  access_token=$(echo "$vcd_session_token_response" | jq -r '.access_token')

  # echo "Access Token is: $access_token"

  # Wait in 30 seconds loop upto 60 minutes (120 times x 30 seconds), for the vm rde state to become RESOLVED
  for i in $(seq 1 120); do
    # Send GET request to fetch swisscom vm rde instance
    # e.g. https://sci01.test.private.cloud.swisscom.ch/cloudapi/1.0.0/entities/urn:vcloud:entity:swisscom:vm:4afbd95f-86bb-4934-be31-5f00e449bd69
    swisscom_vm_rde_response=$(curl --request GET 'https://{{vcd_host}}/cloudapi/1.0.0/entities/{{vm_rde_urn}}' \
    --header "Accept: application/*;version=39.0" \
    --header "Authorization: Bearer $access_token")
    
    #echo "swisscom_vm_rde_response is:" $swisscom_vm_rde_response
    # Check if the vm rde state is RESOLVED
    if [ $(echo "$swisscom_vm_rde_response" | jq -r '.state') == "RESOLVED" ]; then
        echo "VM is ready!"
        
        swisscom_vm_rde_state=$(echo "$swisscom_vm_rde_response" | jq -r '.state')
        echo "Swisscom VM RDE State: $swisscom_vm_rde_state"

        swisscom_vm_name=$(echo "$swisscom_vm_rde_response" | jq -r '.name')
        echo "Swisscom VM Name: $swisscom_vm_name"
        
        break   
    else
        echo "[Attempts remaining: $((120 - $i))] Waiting for VM to be created..."
        sleep 30
    fi
  done  
else
  echo "Failed to retrieve VCD session token"
fi
