provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

variable "subscription_id" {
  description = "Somnath Azure account subscription"
}

variable "client_id" {
  description = "Terraform service principal id"
}

variable "client_secret" {
  description = "Password of the service principal"
}

variable "tenant_id" {
  description = "This the account tenant id"
}

