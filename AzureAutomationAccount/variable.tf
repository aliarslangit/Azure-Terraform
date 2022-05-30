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
//------------------------AUTOMATION ACCOUNT CONFIGIRATIONS------------------------------------------

variable "rgname" {
  default = "demorg_automationaccount"
}

variable "location" {
  default = "West US"
}
variable "AutomationAccountName" {
  default = "demoautomationaccount"
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
  default = "DbServer"
}
