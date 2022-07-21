resource "azurerm_subnet" "subnet" {
  for_each = { for k, v in (var.subnet_map): v.name => v if v.delegation == true }
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}
resource "azurerm_subnet" "subnet1" {
  for_each = { for k, v in (var.subnet_map): v.name => v if v.delegation == false}
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies

}