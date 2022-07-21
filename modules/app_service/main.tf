data "azurerm_subnet" "this" {
  for_each = { for k, v in (var.app_service_map): v.name => v }
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_rg
}


data "azurerm_app_service_plan" "this" {
  for_each = { for k, v in (var.app_service_map): v.name => v }
  name                = each.value.service_plan_name
  resource_group_name = each.value.service_plan_Rg
}

resource "azurerm_app_service" "this" {
for_each = { for k, v in (var.app_service_map): v.name => v }
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  app_service_plan_id = data.azurerm_app_service_plan.this[each.value.name].id

}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  for_each = { for k, v in (var.app_service_map): v.name => v }
  app_service_id  = azurerm_app_service.this[each.value.name].id
  subnet_id       = data.azurerm_subnet.this[each.value.name].id
}
