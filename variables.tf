variable "subscription_id" {
  type        = string
  description = "The Subscription ID used for Azure resources"
}

variable "client_id" {
  type        = string
  description = "The Client ID for the Azure service principal"
}

variable "client_secret" {
  type        = string
  description = "The Client Secret for the Azure service principal"
}

variable "tenant_id" {
  type        = string
  description = "The Tenant ID for the Azure service principal"
}

//
//

variable "vm_names" {
  description = "List of names for the virtual machines"
  type        = list(string)
  default     = ["firstvm", "secondvm", "thirdvm", "fourthvm", "fifthvm"]
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
}

variable "vm_size" {
  description = "Size of the Azure Virtual Machine"
  type        = string
  default     = "Standard_DS1_v2"
}

//
//


variable "admin_username" {
  description = "name of the admin unsername"
  type        = string
}

variable "admin_password" {
  description = "password of the admin"
  type        = string
}
