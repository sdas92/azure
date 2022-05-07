# Declare all variable & types (if requried).
# Author: Somnath Das

#Your subscription ID from Azure
variable "subscription_id" {
  type        = string
  default     = "00c9b468-5a13-44d5-8dcc-403e8c2f87fe" 
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

# VNet Name
/*
variable "vnet_name" {
  type = string
}*/

# CIDR List
variable "cidr_range" {
  type = list
}

