locals {

  // Decode the YAML configuration file to get the VM settings
  vm_config = yamldecode(file("${path.module}/configs/vm-config.yaml"))["vms"]

   common_tags = {
      ManagedBy = "Terraform"
      Environment = "Dev"
   }
}
