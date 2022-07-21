variable "azurerm_lb_map" {
    type = map(object({
                      lbname =string
                      subnetname = string
                      virtual_network_name =string
                      vlanRG = string
                      lblocation= string
                      resource_group_name= string
                      lbsku=string
                      lbfrontendipconfigurationname= string
                      lbfrontendipconfigurationprivateipaddressallocation= string
                  }))
 
}

