variable "app_service_map" {
    type = map(object({
        name = string
        location=string
        service_plan_name=string
        resource_group_name= string
        service_plan_Rg=string
        virtual_network_rg=string
        virtual_network_name=string
        subnetname=string
    }))
}