variable "nsgrules" {
  description = "Multiple nsg create"
  type = map(object({
    name                        = string
    direction                   = string
    access                      = string
    priority                    = number
    protocol                    = string
    source_port_range           = string
    destination_port_ranges      = list(number)
    source_address_prefixes       = string
    destination_address_prefix  = string
    resourcegroupname           = string
    networksecuritygroup        = string
  }))
}
