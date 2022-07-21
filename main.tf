provider "azurerm" {
  features {}
skip_provider_registration =true
}
terraform {
  backend "azurerm" {
    storage_account_name = "azureterrafromstatefile"
    container_name       = "statefile"
    key                  = "demoterraform1"
    access_key           = "LMqoLq7C+UECGbzN9Pu7Gu9LJySs6rKGe0hXiklz4mTC79eNs6qxLvF9L3ULIYIDizYZ4m3eCNUi+AStr4I6Vg=="
  }
}
module "virtual_network" {
    source = "./modules/vlan"
    virtual_network_map =var.virtual_network_map
    tags=var.tags 
}
module "subnet" {
    source = "./modules/subnet"
    subnet_map =var.subnet_map
        depends_on = [
      module.virtual_network
    ]
}

module "availabilityset" {
    source = "./modules/availabilityset"
    availability_set_map=var.availability_set_map
    tags=var.tags  
    depends_on = [
      module.subnet
    ]
}
module "vm" {
        source = "./modules/vm"
        vm_map =var.vm_map
        tags=var.tags  
        depends_on = [
      module.availabilityset
    ]
}
module "vmext" {
        source = "./modules/vmext"
        vm_map =var.vm_map
        depends_on = [
      module.vm
    ]
}
module "nsg" {
  source  = "./modules/nsg"
  azurerm_network_security_group=var.azurerm_network_security_group
  depends_on = [module.subnet]
}
module "nsgassociation" {
  source  = "./modules/nsgassociation"
 nsgassociation_map=var.nsgassociation_map
  depends_on = [module.nsg]
}






module "lb" {
        source = "./modules/lb"
        azurerm_lb_map =var.azurerm_lb_map
     #   tags=var.tags  
        depends_on = [
      module.vm
    ]
}
module "lbbackendaddresspool" {
        source = "./modules/lbbackendaddresspool"
        lb_backend_address_pool_map =var.lb_backend_address_pool_map
        depends_on = [
      module.lb
    ]
}
module "lbprobe" {
        source = "./modules/lbprobe"
        lb_probe_map =var.lb_probe_map
        depends_on = [
      module.lbbackendaddresspool
    ]
}
module "lbrule" {
        source = "./modules/lbrule"
        lb_rule_map =var.lb_rule_map
        depends_on = [
      module.lbprobe
    ]
}
module "lb_backend_address_pool_address" {
        source = "./modules/lb_backend_address_pool_address"
        lb_backend_address_pool_address_map =var.lb_backend_address_pool_address_map
        depends_on = [
      module.lbrule
    ]
}


module "app_service_plan" {
        source = "./modules/app_service_plan"
        azurerm_service_plan_map =var.azurerm_service_plan_map
        depends_on = [
      module.lb_backend_address_pool_address
    ]
}
module "app_service" {
        source = "./modules/app_service"
        app_service_map =var.app_service_map
        depends_on = [
      module.app_service_plan
    ]
}

module "dns" {
  source  = "./modules/dns"
 dnsmap_map=var.dnsmap_map
  depends_on = [module.lb]
}
