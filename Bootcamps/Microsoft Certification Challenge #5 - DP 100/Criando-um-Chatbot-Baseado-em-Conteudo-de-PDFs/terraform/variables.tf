variable "project_name" {
  description = "Nome do projeto para o chatbot"
  type        = string
  default     = "pdf-chatbot-foundry"
}

variable "location" {
  description = "Região do Azure"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
  default     = "rg-pdf-chatbot"
}
