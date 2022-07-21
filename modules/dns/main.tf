

data "azurerm_public_ip" "this" {
  for_each = { for k, v in (var.dnsmap_map): v.name => v }
  name                = each.value.publiceipname
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_dns_zone" "this" {
  for_each = { for k, v in (var.dnsmap_map): v.name => v }
  name                = each.value.zone_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_dns_a_record" "this" {
  for_each = { for k, v in (var.dnsmap_map): v.name => v }
  name                = each.value.publiceipname
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = 600
  records             = [data.azurerm_public_ip.this[each.value.name].ip_address]
          depends_on = [
      azurerm_dns_zone.this
    ]
}





