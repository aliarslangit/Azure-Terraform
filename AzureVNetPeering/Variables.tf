
//-------------------------------Service principal------------------------------//

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

//----------------------------------------------------------\\

variable "system" {
  type        = string
  description = "Name of the system or environment"
  default     = "hubnspoke"
}

variable "hub_location" {
  type        = string
  description = "Azure region location of Virtual Network"
  default     = "westus2"

}

variable "spokes" {
  type    = string
  default = 2
}

//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Ali"
  description = "description"
}

variable "environment" {
  type    = string
  default = "Dev"
}

