data "azurerm_public_ip" "this" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                =  "publicip-${each.value.vmname}"
  resource_group_name = each.value.resource_group_name
}
data "azurerm_virtual_machine" "this" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                = each.value.vmname
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_virtual_machine_extension" "iis-vm-extension" {
  for_each = { for k, v in (var.vm_map): v.vmname => v }
  name                 = "iis-${each.value.vmname}-vm"
  virtual_machine_id   = data.azurerm_virtual_machine.this[each.value.vmname].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
 #automatic_upgrade_enabled =true
   settings = <<SETTINGS
    { 
     "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath ssl.ps1\" && powershell -ExecutionPolicy Unrestricted -File ssl.ps1"
    } 
  SETTINGS
 
}
data "template_file" "tf" {
    template = "${file("ssl.ps1")}"
} 
resource "null_resource" "VM" {
    for_each = { for k, v in (var.vm_map): v.vmname => v }
  provisioner "file" {
    source      = "cats.jpg"
    destination = "C:\\inetpub\\wwwroot\\cats.jpg"
    connection {
      type     = "winrm"
      user     = "${each.value.vmadminusername}"
      password = "${each.value.vmadminpassword}"
      host     = data.azurerm_public_ip.this["${each.value.vmname}"].ip_address
      port     = "5985"
      timeout  = "20m"
    }
  }

}

