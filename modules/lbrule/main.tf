data "azurerm_lb" "this" {
  for_each = { for k, v in (var.lb_rule_map): v.name => v }
  name                = each.value.lbname
  resource_group_name = each.value.resource_group_name
}
data "azurerm_lb_backend_address_pool" "this" {
    for_each = { for k, v in (var.lb_rule_map): v.name => v }
  name            = each.value.backend_address_pool_name
  loadbalancer_id = data.azurerm_lb.this[each.value.name].id
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each = { for k, v in (var.lb_rule_map): v.name => v }
  loadbalancer_id                = data.azurerm_lb.this[each.value.name].id
  name                           = each.value.name
  protocol                       = each.value.lbruleprotocol
  frontend_port                  = each.value.lbrulefrontendport
  backend_port                   = each.value.lbrulebackendport
  frontend_ip_configuration_name = each.value.lbrulefrontendipconfigurationname
  backend_address_pool_ids= [data.azurerm_lb_backend_address_pool.this[each.value.name].id]
}
