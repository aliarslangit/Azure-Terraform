//------------------------------------Service Principal---------------\\
variable "azure_subscription_id" {
  type        = string
  default     = ""
  description = "description"
}

variable "azure_client_id" {
  type        = string
  default     = ""
  description = "description"
}

variable "azure_client_secret" {
  type        = string
  default     = ""
  description = "description"
}

variable "azure_tenant_id" {
  type        = string
  default     = ""
  description = "description"
}
//----------------------------------------------//
variable "rgname" {
  type        = string
  default     = "RG-demo-VMs"
  description = "Enter Azure Resource group name"
}

variable "location" {
  type        = string
  default     = "East US 2"
  description = "Enter region"
}
variable "db_size" {
  type        = string
  default     = "5120"
  description = "Enter database name"
}
variable "db_name" {
  type        = string
  default     = "exampledb"
  description = "Enter database name"
}

variable "db_server" {
  type        = string
  default     = "example-mysqlserver"
  description = "ener database server name"
}
variable "username" {
  type        = string
  default     = "adminuser"
  description = "ener database server username"
}
variable "command" {
  type    = string
  default = "apply"
}
//------------------------------------TAGS-------------------------\\
variable "owner" {
  type    = string
  default = "Ali"
}

variable "Environment" {
  type    = string
  default = "PRD"
}
