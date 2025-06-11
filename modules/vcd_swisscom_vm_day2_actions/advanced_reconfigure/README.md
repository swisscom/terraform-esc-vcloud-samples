# Enterprise Service Cloud - Infrastructure as Code with Terraform (Swisscom Virtual Machine Day2 actions)
## 🌟 Description
This **Terraform module** provides sample code to execute **custom Day 2 actions** on **Swisscom Virtual Machines** in VMware Cloud Director (VCD).

In this sample, we demonstrate how to execute the **Advanced Reconfigure Day 2** action, which allows you to modify the following aspects of the Virtual Machine: Location, Service Level and Storage Policies.

The RDE (Runtime Defined Entity) behavior invocation feature in VMware Cloud Director (VCD) is leveraged to execute custom Day 2 actions on **Swisscom Virtual Machines**.

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
   - Sample Terraform code to execute a custom Day 2 Action: **Advanced Reconfigure** on a Swisscom Virtual Machine.

4. **`/schemas/advanced_reconfigure_json.tpl`**  
   - This is the **JSON template file** used to define the schema and the request payload for executing the **Advanced Reconfigure** Day 2 action on a **Swisscom Virtual Machine** using RDE (Runtime Defined Entity) behavior invocation..          

---

## 🚀 Usage Instructions
Follow these steps to deploy and manage infrastructure using Terraform:

1. Open your terminal and navigate to:
   ```bash
   cd /terraform-esc-vcloud-samples/modules/vcd_swisscom_vm_day2_actions
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
4. Plan or apply changes:
   ```bash
   terraform plan -var-file="config-values.tfvars"
        or
   terraform apply -var-file="config-values.tfvars" 
   ```
   _(Triggers Advanced Reconfigure Day2 action.)_

---

## 🔗 References
- 📖 [Terraform Documentation](https://www.terraform.io/)
- ☁️  [Cloud Director Virtual Machine Resource](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vm)
- ☁️  [Cloud Director RDE Resource](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/rde)
- ☁️  [Cloud Director RDE Behavior Invocation Data Source](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/rde_behavior_invocation)
- ☁️  [Cloud Director RDE Official Documentation](https://techdocs.broadcom.com/us/en/vmware-cis/cloud-director/vmware-cloud-director/10-6/vcd-ext-developer-guide/extensibility-platform-defined-entities-defined-entities-overview.html)
- 🛠 [Getting Started with Terraform](https://learn.hashicorp.com/terraform/getting-started/install)


---

✅ **Maintained By:** Swisscom Enterprise Service Cloud Team