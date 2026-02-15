variable "resource_group_name" {
  type    = string
  default = "rg-ml-corn-prediction"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "storage_account_name" {
  type    = string
  default = "stmlcornpred"
}

variable "key_vault_name" {
  type    = string
  default = "kv-ml-corn-pred"
}

variable "app_insights_name" {
  type    = string
  default = "ai-ml-corn-pred"
}

variable "workspace_name" {
  type    = string
  default = "mlw-corn-prediction"
}

variable "tenant_id" {
  type        = string
  description = "The Azure tenant ID. You can find this in the Azure portal."
}
