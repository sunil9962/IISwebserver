data "azurerm_virtual_machine" "this" {
  for_each = { for k, v in (var.lb_backend_address_pool_address_map): v.vmname => v }
  name                = each.value.vmname
  resource_group_name = each.value.vmrg
}
data "azurerm_virtual_network" "this" {
  for_each = { for k, v in (var.lb_backend_address_pool_address_map): v.vmname => v }
  name                = each.value.vlanname
  resource_group_name = each.value.vlanrg
}
data "azurerm_lb" "this" {
  for_each = { for k, v in (var.lb_backend_address_pool_address_map): v.vmname => v }
  name                = each.value.lbname
  resource_group_name = each.value.lbrg
}
data "azurerm_lb_backend_address_pool" "this" {
    for_each = { for k, v in (var.lb_backend_address_pool_address_map): v.vmname => v }
  name            = each.value.backend_address_pool_name
  loadbalancer_id = data.azurerm_lb.this[each.value.vmname].id
}
resource "azurerm_lb_backend_address_pool_address" "this" {
      for_each = { for k, v in (var.lb_backend_address_pool_address_map): v.vmname => v }
      name                    = each.value.vmname
      backend_address_pool_id = data.azurerm_lb_backend_address_pool.this[each.value.vmname].id
      virtual_network_id      = data.azurerm_virtual_network.this[each.value.vmname].id
      ip_address              = data.azurerm_virtual_machine.this[each.value.vmname].private_ip_address
}


