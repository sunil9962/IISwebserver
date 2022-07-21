variable "lb_probe_map" {
    type = map(object({
                      lbname = string
                      resource_group_name =string 
                      lbprobename =string 
                      lbprobeprotocol=string 
                      lbprobeport=number 
                      lbprobeintervalinseconds=number 
                      lbprobenumberofprobes=number 
                  })) 
}