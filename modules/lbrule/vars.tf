
variable "lb_rule_map" {
    type = map(object({
                      name =string
                      lbname = string
                      resource_group_name =string 
                      backend_address_pool_name=string 
                      lbruleprotocol =string 
                      lbrulefrontendport=number 
                      lbrulebackendport=number 
                      lbrulefrontendipconfigurationname=string 
                  })) 
}