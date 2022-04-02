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
//------------------------ServiceBus CONFIGIRATIONS------------------------------------------

variable "rgname" {
  default = "demorg_sb"
}

variable "location" {
  default = "West US"
}

variable "servicebusname" {
  default = "demovisionsb"
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

