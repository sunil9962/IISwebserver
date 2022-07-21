variable "lb_backend_address_pool_address_map" {
    type = map(object({
                      vmname =string
                      vmrg= string
                      vlanname= string
                      vlanrg= string
                      lbname= string
                      lbrg= string
                      backend_address_pool_name= string

    })) 
}