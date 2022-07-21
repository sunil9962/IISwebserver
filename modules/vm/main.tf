
data "azurerm_availability_set" "this" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                = each.value.availabilitysetname
  resource_group_name = each.value.resource_group_name
}
data "azurerm_subnet" "this" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_rg
}
resource "azurerm_network_interface" "main" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                = "${each.value.vmname}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "${each.value.vmname}-ip"
    subnet_id                     = data.azurerm_subnet.this[each.value.vmname].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main[each.value.vmname].id
  }
}
resource "azurerm_public_ip" "main" {
    for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                =  "publicip-${each.value.vmname}"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"

}
resource "azurerm_virtual_machine" "this" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                = each.value.vmname
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  vm_size                = each.value.vmsize
  tags = var.tags
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  network_interface_ids = [azurerm_network_interface.main[each.value.vmname].id]
  availability_set_id = data.azurerm_availability_set.this[each.value.vmname].id
  storage_image_reference {
    publisher = each.value.imagepublisher
    offer     = each.value.imageoffer
    sku       = each.value.imagesku
    version   = each.value.imageversion
  }
  storage_os_disk {
    name              = "${each.value.vmname}-os"
    caching           = each.value.vmosdiskcaching
    create_option     = "FromImage"
    managed_disk_type = each.value.vmosdiskstorageaccounttype
    disk_size_gb =each.value.disk_size_gb
  }
  os_profile {
    computer_name  = each.value.vmname
    admin_username = each.value.vmadminusername
    admin_password = each.value.vmadminpassword
  }
   os_profile_windows_config {
    provision_vm_agent = true
    enable_automatic_upgrades=true
    winrm {
       protocol="HTTP"
     }
  }


}
