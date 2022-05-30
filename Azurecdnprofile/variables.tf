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
//------------------------CDN CONFIGIRATIONS------------------------------------------

variable "rgname" {
  default = "demorg_cdn"
}

variable "location" {
  default = "West US"
}
variable "profilename" {
  default = "democdn"
}

variable "st_name" {
  default = "democdnendpointsto"
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

