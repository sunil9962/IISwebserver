resource "azurerm_network_security_rule" "nsgrule" {
  for_each = { for k, v in (var.nsgrules): v.name => v }
  name                        = each.value.name
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_ranges      = each.value.destination_port_ranges
 
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = each.value.resourcegroupname
  network_security_group_name = each.value.networksecuritygroup
}