

resource "azurerm_app_service_plan" "this" {
  for_each = { for k, v in (var.azurerm_service_plan_map): v.name => v }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            =each.value.location

  sku {
    tier = each.value.skutier
    size = each.value.skusize
  }
}

resource "azurerm_monitor_autoscale_setting" "this" {
  for_each = { for k, v in (var.azurerm_service_plan_map): v.name => v }
  name                = "${each.value.name}-Autoscale"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  target_resource_id  = azurerm_app_service_plan.this[each.value.name].id
  profile {
    name = "default"
    capacity {
      default = 1
      minimum = 1
      maximum = 10
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.this[each.value.name].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 90
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

  }  
}