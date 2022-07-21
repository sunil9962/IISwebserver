variable "vm_map" {
    type = map(object({
      subnetname=string
      virtual_network_name=string
      virtual_network_rg=string
      resource_group_name=string
      availabilitysetname =string
      location=string
      vmname=string
      vmsize=string
      imagepublisher=string
      imageoffer=string
      imagesku=string
      imageversion=string
      vmosdiskcaching=string
      vmosdiskstorageaccounttype=string
      vmadminusername=string
      vmadminpassword=string
      disk_size_gb =number
    }))
}
variable "tags" {
  type = map

  default = {
    Environment = "Terraform GS"
    Dept        = "Engineering"
  }
}




