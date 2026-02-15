resource "azurerm_machine_learning_compute_cluster" "compute" {
  name                          = "cpu-cluster"
  location                      = azurerm_resource_group.ml_rg.location
  vm_priority                   = "LowPriority"
  vm_size                       = "Standard_DS3_v2"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.ml_ws.id

  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 2
    scale_down_nodes_after_idle_duration = "PT15M" # 15 minutes
  }
}
