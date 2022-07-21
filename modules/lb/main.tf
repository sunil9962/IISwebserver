
resource "azurerm_public_ip" "this" {
for_each = { for k, v in (var.azurerm_lb_map): v.lbname => v }
  name                = each.value.lbname
  location            = each.value.lblocation
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku = "Standard"
}
resource "azurerm_lb" "lbspokeweb" {
  for_each = { for k, v in (var.azurerm_lb_map): v.lbname => v }
  name                = each.value.lbname
  location            = each.value.lblocation
  resource_group_name = each.value.resource_group_name
  sku = each.value.lbsku
  frontend_ip_configuration {
   name                 = each.value.lbfrontendipconfigurationname
   public_ip_address_id = azurerm_public_ip.this[each.value.lbname].id
  }
}

