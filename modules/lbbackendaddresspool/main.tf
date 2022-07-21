data "azurerm_lb" "this" {
  for_each = { for k, v in (var.lb_backend_address_pool_map): v.name => v }
  name                = each.value.lbname
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_lb_backend_address_pool" "lb-backendpool" {
  for_each = { for k, v in (var.lb_backend_address_pool_map): v.name => v }
  loadbalancer_id     = data.azurerm_lb.this[each.value.name].id
  name                = each.value.name
}

