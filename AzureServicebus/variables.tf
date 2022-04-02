//-------------------------------Service principal------------------------------//

variable "azure_subscription_id" {
  type        = string
  default     = "8e485c9b-6527-441b-a8c3-51058f8daf6e"
  description = "description"
}

variable "azure_client_id" {
  type        = string
  default     = "f28087fc-6a58-4c27-a657-352406c207df"
  description = "description"
}

variable "azure_client_secret" {
  type        = string
  default     = "V0-kUdG~a-o4ae64Qt~Ah0Pj6_VKo87P8m"
  description = "description"
}

variable "azure_tenant_id" {
  type        = string
  default     = "f37bc64f-a244-47ff-b13f-d5439eef9b08"
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
  default     = "Ravi"
  description = "description"
}

variable "environment" {
  type        = string
  default     = "Dev"
}

variable "businessunit" {
  type        = string
  default     = "HR"
}

variable "application" {
  type        = string
  default     = "SB"
}