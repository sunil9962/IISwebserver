variable "azurerm_network_security_group" {
  description = "Multiple nsg create"
  type = map(object({
    resource_group_name        = string
    location    = string
    name                     = string
    tags = map(string)
  }))
}
