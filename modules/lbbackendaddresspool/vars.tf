
variable "lb_backend_address_pool_map" {
    type = map(object({
                      name =string
                      lbname = string
                      resource_group_name =string                    
                  })) 
}