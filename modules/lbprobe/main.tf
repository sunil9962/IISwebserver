data "azurerm_lb" "this" {
  for_each = { for k, v in (var.lb_probe_map): v.lbprobename => v }
  name                = each.value.lbname
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb_probe" "lb_probe" {
  for_each = { for k, v in (var.lb_probe_map): v.lbprobename => v }
  loadbalancer_id     = data.azurerm_lb.this[each.value.lbprobename].id
  name                = each.value.lbprobename
  protocol            = each.value.lbprobeprotocol
  port                = each.value.lbprobeport
  interval_in_seconds = each.value.lbprobeintervalinseconds
  number_of_probes    = each.value.lbprobenumberofprobes
}


