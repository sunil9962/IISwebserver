variable "azurerm_service_plan_map" {
    type = map(object({
        name = string
        location=string
        skutier=string
        resource_group_name= string
        skusize=string
    }))
}
