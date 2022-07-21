variable "subnet_map" {
    type = map(object({
        name = string
        virtual_network_name=string
        resource_group_name =string
        address_prefixes=list(string)
        enforce_private_link_endpoint_network_policies =bool
        delegation=bool
    }))
}

