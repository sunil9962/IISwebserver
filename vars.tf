variable "virtual_network_map" {
    type = map
    default={
      a={
        name = "vlan001"
        resource_group_name = "devops-interview-guantlet-x-skatipally"
        location = "eastus"
        address_space= ["10.18.172.0/23","10.18.166.0/23"]
      }
    }
}
variable "subnet_map" {
    type = map
    default={
      vm={
        virtual_network_name = "vlan001"
        resource_group_name = "devops-interview-guantlet-x-skatipally"
        name = "subnet001-10.18.166.0_25"
        address_prefixes= ["10.18.166.0/25"]
        enforce_private_link_endpoint_network_policies = false
        delegation= false
      }
    app={
        virtual_network_name = "vlan001"
        resource_group_name = "devops-interview-guantlet-x-skatipally"
        name = "subnet001-10.18.167.0_24"
        address_prefixes= ["10.18.167.0/24"]
        enforce_private_link_endpoint_network_policies = true
        delegation=true
      } 
    }
}
variable "tags" {
 description = "A map of the tags to use for the resources that are deployed"
 type        = map(string)

 default = {
   APPNAME = "AIMS-LAB",
   costcenter = "802290",
   ppm = "Closed"
 }
}

variable "availability_set_map" {
    type = map
    default={
      a={
        name = "vmavalset001"
        resource_group_name = "devops-interview-guantlet-x-skatipally"
        location = "eastus"
        fault_domain_count=2
        update_domain_count=5
      }

    }
}
variable "vm_map" {
   type = map 
   default={
     a={

    subnetname="subnet001-10.18.166.0_25"
    virtual_network_name="vlan001"
    virtual_network_rg="devops-interview-guantlet-x-skatipally"
    resource_group_name="devops-interview-guantlet-x-skatipally"
    location= "eastus"
    vmname="vm01"
    vmsize="Standard_A2"
    imagepublisher="MicrosoftWindowsServer"
    availabilitysetname="vmavalset001"
    imageoffer="WindowsServer"
    imagesku="2016-Datacenter"
    imageversion="latest"
    vmosdiskcaching="ReadWrite"
    vmosdiskstorageaccounttype="Standard_LRS"
    vmadminusername="testadmin"
    vmadminpassword="pD+f:FVkw36zG(8h"
    disk_size_gb =127
      }


    b={

    subnetname="subnet001-10.18.166.0_25"
    virtual_network_name="vlan001"
    virtual_network_rg="devops-interview-guantlet-x-skatipally"
    resource_group_name="devops-interview-guantlet-x-skatipally"
    location= "eastus"
    vmname="vm02"
    vmsize="Standard_A2"
    imagepublisher="MicrosoftWindowsServer"
    availabilitysetname="vmavalset001"
    imageoffer="WindowsServer"
    imagesku="2016-Datacenter"
    imageversion="latest"
    vmosdiskcaching="ReadWrite"
    vmosdiskstorageaccounttype="Standard_LRS"
    vmadminusername="testadmin"                                       
    vmadminpassword="pD+f:FVkw36zG(8h"
    disk_size_gb =127
      }
    }
}

variable "azurerm_lb_map" {
    type = map
    default={
     a={ 
            lbname ="webnlb"
            subnetname = "subnet001-10.18.166.0_25"
            virtual_network_name ="vlan001"
            vlanRG = "devops-interview-guantlet-x-skatipally"
            lblocation= "eastus"
            resource_group_name= "devops-interview-guantlet-x-skatipally"
            lbsku="Standard"
            lbfrontendipconfigurationname= "LoadBalancerFrontEnd"
            lbfrontendipconfigurationprivateipaddressallocation= "Dynamic"                      
    }
  }
}

variable "lb_backend_address_pool_map" {
    type = map
    default={
     a={ 
                      name ="backendpool"
                      lbname = "webnlb"
                      resource_group_name ="devops-interview-guantlet-x-skatipally"                     
    }
  }
}

variable "lb_probe_map" {
    type = map
    default={
     a={ 
            lbname = "webnlb"
            resource_group_name ="devops-interview-guantlet-x-skatipally" 
            lbprobename ="s00333hpboxwct" 
            lbprobeprotocol="Tcp" 
            lbprobeport=80 
            lbprobeintervalinseconds=5 
            lbprobenumberofprobes=2                    
    }
    b={ 
            lbname = "webnlb"
            resource_group_name ="devops-interview-guantlet-x-skatipally" 
            lbprobename ="s00333hpboxwct1" 
            lbprobeprotocol="Tcp" 
            lbprobeport=443
            lbprobeintervalinseconds=5 
            lbprobenumberofprobes=2                    
    }
  }
}
variable "lb_rule_map" {
    type = map
    default={
     a={ 
            lbname = "webnlb"
            resource_group_name ="devops-interview-guantlet-x-skatipally" 
            name ="s00333lbrboxwct"
            backend_address_pool_name="backendpool"
            lbruleprotocol ="Tcp"
            lbrulefrontendport=80 
            lbrulebackendport=80
            lbrulefrontendipconfigurationname="LoadBalancerFrontEnd"               
    }
    b={ 
            lbname = "webnlb"
            resource_group_name ="devops-interview-guantlet-x-skatipally" 
            name ="s00333lbrboxwct1"
            backend_address_pool_name="backendpool"
            lbruleprotocol ="Tcp"
            lbrulefrontendport=443 
            lbrulebackendport=443
            lbrulefrontendipconfigurationname="LoadBalancerFrontEnd"               
    }
  }
}
variable "lb_backend_address_pool_address_map" {
    type = map
    default={
     a={ 
            vmname ="vm01"
            vmrg= "devops-interview-guantlet-x-skatipally" 
            vlanname= "vlan001"
            vlanrg= "devops-interview-guantlet-x-skatipally" 
            lbname= "webnlb"
            lbrg= "devops-interview-guantlet-x-skatipally" 
            backend_address_pool_name= "backendpool"
           
    }
    b={ 
            vmname ="vm02"
            vmrg= "devops-interview-guantlet-x-skatipally" 
            vlanname= "vlan001"
            vlanrg= "devops-interview-guantlet-x-skatipally" 
            lbname= "webnlb"
            lbrg= "devops-interview-guantlet-x-skatipally" 
            backend_address_pool_name= "backendpool"
           
    }
  }
}



variable "app_service_map" {
    type = map
    default={

      app1={
        name = "app1807202210"
        location="eastus"
        service_plan_name= "myapp1807202210"
        resource_group_name= "devops-interview-guantlet-x-skatipally" 
        service_plan_Rg="devops-interview-guantlet-x-skatipally" 
        virtual_network_rg="devops-interview-guantlet-x-skatipally" 
        virtual_network_name="vlan001"
        subnetname="subnet001-10.18.167.0_24"
      }
    }
}



variable "azurerm_service_plan_map" {
    type = map
    default={

      appplan1={
        name = "myapp1807202210"
        location="eastus"
        skutier="Standard"
        resource_group_name= "devops-interview-guantlet-x-skatipally" 
        skusize="S1"
    }
  }
}



variable "azurerm_network_security_group" {
  type = map
  default={
    nsg1={
    resource_group_name        = "devops-interview-guantlet-x-skatipally"
    location    = "eastus"
    name        = "nsg1"
    tags = {
              APPNAME = "AIMS-LAB",
              costcenter = "802290",
              ppm = "Closed"
            }
    }
  }
}


variable "nsgassociation_map" {
  type = map
  default={
    nsg1={
      nsg_name        = "nsg1"
      subnetname    = "subnet001-10.18.166.0_25"
      virtual_network_name        = "vlan001"
      virtual_network_rg    = "devops-interview-guantlet-x-skatipally"
      nsg_rg    = "devops-interview-guantlet-x-skatipally"
   }
  }
}

variable "dnsmap_map" {
    type = map
    default={
      a={
      resource_group_name="devops-interview-guantlet-x-skatipally"
      publiceipname="webnlb"
      zone_name="mycat123.com"
      name="webnlb"
    }
    }
}
