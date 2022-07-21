
data "azurerm_resource_group" "this" {
  for_each = { for k, v in (var.availability_set_map): v.name => v }
  name = each.value.resource_group_name
}

resource "azurerm_availability_set" "this" {
  for_each = { for k, v in (var.availability_set_map): v.name => v }
  name                = each.value.name
  location            = data.azurerm_resource_group.this[each.value.name].location
  resource_group_name = data.azurerm_resource_group.this[each.value.name].name
  tags = var.tags
  platform_fault_domain_count = each.value.fault_domain_count
  platform_update_domain_count = each.value.update_domain_count 

}

