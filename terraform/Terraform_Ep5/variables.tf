# Declare all variable & types (if requried).
# Author: Somnath Das

#Your subscription ID from Azure
variable "subscription_id" {
  type        = string
  default     = "XXXXX-XXXXX-XXXXX-XXXXX" 
  description = "Your deployment subscription ID"
}

# Resource Group Name
variable "rg_name" {
  
}

# Location map
variable "location" {
  type    = map
  description = "A map of locations"
}

# CIDR List for VNET
variable "cidr_range" {
  type = list
}

#Subnet Map
variable "subnet_map" {
  type = map
}

#NIC IP list
variable "nic_list" {
  type = list(map(string))
}

#Storage check
variable "strage_check" {
  type = string
}

