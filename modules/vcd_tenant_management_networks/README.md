# Enterprise Service Cloud - Infrastructure as Code with Terraform (Networks)
## 🌟 Description
This Terraform module provides sample Terraform code to provision and manage **routed networks** in VMware Cloud Director (VCD). Routed networks can be assigned to organizations for workload VM connectivity.

### 🔹 Steps to Access & Configure
1. **Login** to the **Swisscom Enterprise Service Cloud Portal** as an **IaaS Sub-Provider Administrator**.
2. Navigate to **Uplink Topology** (Uplink Topology: provides enterprise connectivity for the tenant).
3. Create **Edge Gateways** (Edge Gateway: provides further network isolation within the tenant).

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

4. **`routed_network_web.tf`**  
   - Sample script to create and manage a routed network in Cloud Director using Terraform.

---

## 🚀 Usage Instructions
Follow these steps to deploy and manage infrastructure using Terraform:

1. Open your terminal and navigate to:
   ```bash
   cd /terraform-esc-vcloud-samples/modules/vcd_tenant_management_networks
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
6. Destroy infrastructure:
   ```bash
   terraform destroy -var-file="config-values.tfvars"
   ```
   _(Removes all managed resources.)_

---

## 🔗 References
- 📖 [Terraform Documentation](https://www.terraform.io/)
- ☁️  [Cloud Director Terraform Provider](https://registry.terraform.io/providers/vmware/vcd/latest/docs)
- 🛠 [Getting Started with Terraform](https://learn.hashicorp.com/terraform/getting-started/install)

---

✅ **Maintained By:** Swisscom Enterprise Service Cloud Team