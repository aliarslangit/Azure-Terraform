//-------------------------------Service principal------------------------------//

vvariable "azure_subscription_id" {
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

//------------------------CONFIGIRATIONS------------------------------------------//

variable "rgname" {
  default = "test_demorgfrontdoor"
}

variable "location" {
  default = "West US"
}

variable "fdname" {
  default = "demovisionetfd"
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

variable "businessunit" {
  type    = string
  default = "HR"
}

variable "application" {
  type    = string
  default = "Retail"
}

