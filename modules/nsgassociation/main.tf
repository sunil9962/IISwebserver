data "azurerm_subnet" "this" {
  for_each = { for k, v in (var.nsgassociation_map): v.nsg_name => v }
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_rg
}
data "azurerm_network_security_group" "this" {
  for_each = { for k, v in (var.nsgassociation_map): v.nsg_name => v }
  name                = each.value.nsg_name
  resource_group_name = each.value.nsg_rg
}

resource "azurerm_subnet_network_security_group_association" "nsgaassociation" {
  for_each = { for k, v in (var.nsgassociation_map): v.nsg_name => v }
  subnet_id                 = data.azurerm_subnet.this[each.value.nsg_name].id
  network_security_group_id = data.azurerm_network_security_group.this[each.value.nsg_name].id
}

