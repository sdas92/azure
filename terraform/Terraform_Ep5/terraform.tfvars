# Input values for the varables declared in variables.tf file
#Author: Somnath Das

#Subscription
subscription_id = "1d4bfebb-7fb1-4d2b-8104-1d21f9891534"

#RG Name
rg_name = "das-rg" 

# Map of locations (key-value pair)
location = {
    apac = "eastasia"
    emea = "northeurope"
    amer = "eastus"
}

# CIDR List
cidr_range = ["10.0.0.0/24","20.0.0.0/24"]

#Subnet Map
subnet_map = {
    web_sub  = "10.0.0.0/28"
    app_sub  = "10.0.0.16/28"
    data_sub = "10.0.0.32/28"
}

#NIC List
nic_list = [ 
    {
        nic_name = "web-srv1"
        nic_ip   = "10.0.0.21"
    },
    {
        nic_name = "web-srv2"
        nic_ip   = "10.0.0.22"
    }
]
