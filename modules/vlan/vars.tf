variable "virtual_network_map" {
    type = map(object({
        name = string
        resource_group_name =string
        address_space=list(string)
        location=string
    }))
}

 variable "tags" {
  type = map

  default = {
    Environment = "Terraform GS"
    Dept        = "Engineering"
  }
}

