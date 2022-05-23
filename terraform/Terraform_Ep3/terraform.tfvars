# Input values for the varables declared in variables.tf file
#Author: Somnath Das

#RG Name
rg_name = "manual-rg" 

# Map of locations (key-value pair)
location = {
    apac = "eastasia"
    emea = "northeurope"
    amer = "eastus"
}

#Network Name
vnet_name = "manual-vnet"

# CIDR List
cidr_range = ["10.0.0.0/24","20.0.0.0/24","30.0.0.0/16"]

