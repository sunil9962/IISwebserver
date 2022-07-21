resource "azurerm_network_security_group" "this" {
  for_each = { for k, v in (var.azurerm_network_security_group): v.name => v }
  name     = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  tags = each.value.tags
  security_rule {  //Here opened https port
    name                       = "HTTPS"  
    priority                   = 1000  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "443"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened WinRMport
    name                       = "winrm"  
    priority                   = 1010  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "5985"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened https port for outbound
    name                       = "winrm-out"  
    priority                   = 100  
    direction                  = "Outbound"  
    access                     = "Allow"  
    protocol                   = "*"  
    source_port_range          = "*"  
    destination_port_range     = "5985"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened https port for outbound
    name                       = "winrm-in"  
    priority                   = 121  
    direction                  = "Outbound"  
    access                     = "Allow"  
    protocol                   = "*"  
    source_port_range          = "*"  
    destination_port_range     = "5986"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened remote desktop port
    name                       = "RDP"  
    priority                   = 110  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "3389"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  } 
 security_rule {   
    name                       = "Http"  
    priority                   = 111  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "80"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  } 
}
output "obj" {
  value =  azurerm_network_security_group.this
  depends_on = [azurerm_network_security_group.this]
}

