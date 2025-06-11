# Enterprise Service Cloud - Infrastructure as Code with Terraform (Swisscom Virtual Machine)
## 🌟 Description
This Terraform module provides sample Terraform code to provision and manage **Swisscom Virtual Machines** in VMware Cloud Director (VCD).

The RDE **(Runtime Defined Entity)** feature in VCD is utilized to provision **Swisscom Virtual Machine** resources. Once the RDE instance is RESOLVED, it creates a Virtual Machine in Cloud Director with Swisscom-specific configurations.

### 🔹 Steps to Access & Configure
1. **Login** to the **Swisscom Enterprise Service Cloud Portal** as an **IaaS Organization Administrator**.
2. Select **Space** and navigate to **IaaS Services**.
3. Make sure **VCD Organization** and **Virtual Data Center** are created in Swisscom Cloud Portal.

---

## 📂 File Overview
### 🔧 **Key Configuration Files**

1. **`config-values.tfvars`**  
   - Used to pass configuration values to Terraform commands (`apply/destroy`).
   - Edit this file to update values based on your tenant.

2. **`variables.tf`**  
   - Defines all required variables referenced in this Terraform script.

3. **`versions.tf`**  
   - Specifies the Terraform provider for [Cloud Director](https://github.com/terraform-providers/terraform-provider-vcd).

4. **`global_data_sources.tf`**  
   - Sample script to manage all the data sources needed in this terraform module.

4. **`vm_web_server_01_main.tf`**  
   - Sample script to create and manage Swisscom Vituial Machine in Cloud Director using Terraform.
   - The Terraform `null_resource` is utilized to wait for the RDE to reach the `RESOLVED` state. The RDE transitions to `RESOLVED` once the VM is successfully created. A shell script is executed as part of the `null_resource`, which triggers VCD API calls to poll for the RDE status until it becomes `RESOLVED`.
   - The `local_file` resource is used to store the generated VM name in a file. This file is then referenced in the `vcd_resource_list` resource, as `null_resource` cannot set variables that can be accessed outside of the resource.
   - Since the VCD Virtual Machine `vcd_vm` is created externally through the RDE feature, we use the `vcd_resource_list` data source to import the created VM into the Terraform state. This allows the VM to be managed (reconfigured, powered on/off, destroyed, etc.) using Terraform.
   - [vcd_resource_list](https://registry.terraform.io/providers/vmware/vcd/latest/docs/guides/importing_resources#more-automated-import-operations) data source offers automated import functionality for VCD Terraform resources.

4. **`vm_web_server_01_import.tf`**  
   - This file will be automatically generated after running `terraform apply`. It contains terraform import statements to import `vcd_vm` resources into the Terraform state.
   
      ```
         # Example: generated import statement to import vcd_vm
         import {
            to = vcd_vm.AAT10110277-234c5ff3e4e5
            id = "aat-101-iaas-terraform-tests.aat-101-iaas-terraform-tests.urn:vcloud:vm:069fdd5a-3658-4923-b073-234c5ff3e4e5"
         }
      ```

4. **`generated_vcd_vm_resources.tf.tf`**  
   - This file will be automatically generated after running `terraform plan` with the `-generate-config-out=generated_vcd_vm_resources.tf` option. It contains the Terraform VCD `vcd_vm` resources for managing virtual machine resources.
   - You can edit this file as needed to manage (reconfigure, power on/off) the VM resources using Terraform.

4. **`file_web_server_01_vm_name.txt`**  
   - This is an automatically generated local file that stores the VM name. The name of the VM will be automatically generated for Swisscom VMs in the ESC.

4. **`/schemas/swisscom_vm.json.tpl`**  
   - This is the JSON template file used to define the schema and request payload for creating a Swisscom Virtual Machine through RDE.

4. **`/scripts/vcd-rde-api-poll-vm-readiness.sh`**  
   - This is a sample shell script that executes VCD API calls to wait for the RDE to reach the RESOLVED state.            

---

## 🚀 Usage Instructions
Follow these steps to deploy and manage infrastructure using Terraform:

1. Open your terminal and navigate to:
   ```bash
   cd /terraform-esc-vcloud-samples/modules/vcd_swisscom_vm
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
   _(Downloads the Cloud Director provider and initializes Terraform.)_
3. Validate the configuration:
   ```bash
   terraform validate
   ```
4. Plan changes:
   ```bash
   terraform plan -var-file="config-values.tfvars"
   ```
   _(Simulates deployment and shows required changes.)_
5. Apply changes:
   ```bash
   terraform apply -var-file="config-values.tfvars"
   ```
   _(Deploys resources to your ESC Cloud.)_
6. Plan changes with `generate-config-out option`:
   ```bash
   terraform plan -var-file="config-values.tfvars" -generate-config-out=generated_vcd_vm_resources.tf
   ```
   _(Generates the tf file `generated_vcd_vm_resources.tf` with the needed vcd_vm resources.)_  
8. Terraform Apply to import the resources:
   ```bash
   terraform apply -var-file="config-values.tfvars"
   ```
   _(Imports `vcd_vm` resources into terraform state)_      
8. Destroy infrastructure:
   ```bash
   terraform destroy -var-file="config-values.tfvars"
   ```
   _(Removes all managed resources.)_

---

## 🔗 References
- 📖 [Terraform Documentation](https://www.terraform.io/)
- ☁️  [Cloud Director Virtual Machine Resource](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vm)
- ☁️  [Cloud Director RDE Resource](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/rde)
- ☁️  [Cloud Director Importing Virtual Machine Resources](https://registry.terraform.io/providers/vmware/vcd/latest/docs/guides/importing_resources#more-automated-import-operations)
- ☁️  [Cloud Director RDE Official Documentation](https://techdocs.broadcom.com/us/en/vmware-cis/cloud-director/vmware-cloud-director/10-6/vcd-ext-developer-guide/extensibility-platform-defined-entities-defined-entities-overview.html)
- 🛠 [Getting Started with Terraform](https://learn.hashicorp.com/terraform/getting-started/install)


---

✅ **Maintained By:** Swisscom Enterprise Service Cloud Team