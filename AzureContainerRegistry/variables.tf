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

//------------------------CONFIGIRATIONS------------------------------------------//

variable "rgname" {
  type    = string
  default = "test_cmprgacr"
}
variable "acrname" {
  type    = string
  default = "cmpdemoacr"
}

variable "location" {
  type    = string
  default = "East US"
}
variable "sku" {
  type    = string
  default = "premium"
}


//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Ravi"
  description = "description"
}

variable "environment" {
  type    = string
  default = "Dev"
}

