variable "dnsmap_map" {
    type = map(object({
      resource_group_name=string
      publiceipname=string
      zone_name=string
      name=string
    }))
}
