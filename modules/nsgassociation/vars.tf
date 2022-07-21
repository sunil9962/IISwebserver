
variable "nsgassociation_map" {
  type = map(object({
    nsg_name        = string
    subnetname    = string
    virtual_network_name        = string
    virtual_network_rg    = string
    nsg_rg    = string
  }))
}
