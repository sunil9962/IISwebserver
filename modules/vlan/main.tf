resource "azurerm_virtual_network" "vlan" {
 for_each = { for k, v in (var.virtual_network_map): v.name => v }
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  tags= var.tags
}
