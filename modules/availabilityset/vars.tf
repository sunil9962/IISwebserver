
variable "availability_set_map" {
    type = map(object({
        name = string
        fault_domain_count=number
        update_domain_count=number
        resource_group_name =string
    }))
}
 variable "tags" {
  type = map

  default = {
    Environment = "Terraform GS"
    Dept        = "Engineering"
  }
}

