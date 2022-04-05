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
//------------------------General Properties------------------------------------------
variable "vnetname" {
  type    = string
  default = "demo-vnet"

}
variable "rgname" {
  type    = string
  default = "RG-demo-VNET"

}
variable "location" {
  type    = string
  default = "West US"
}
variable "command" {
  type    = string
  default = "West US"
}
//---------------------------VNET CONFIGURATIONS------------------------------
variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet1" {
  type    = string
  default = "privatesubnet"
}
variable "subnet2" {
  type    = string
  default = "publicsubnet"
}
variable "subnet1ip" {
  type    = string
  default = "10.0.3.0/24"
}
variable "subnet2ip" {
  type    = string
  default = "10.0.2.0/24"
}
variable "subnets" {
  type = list(any)
  default = [
    {
      ip   = "10.0.1.0/24"
      name = "subnet-1"
    },
    {
      ip   = "10.0.2.0/24"
      name = "subnet-2"
    }
  ]
}
variable "dns_servers" {
  type    = list(string)
  default = ["10.0.0.4", "10.0.0.5"]
}

//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Ali Arslan"
  description = "description"
}

variable "Environment" {
  type        = string
  default     = "Dev"
  description = "Enter storage account name"
}



//------------------------------------------TF Errors------------------------\\
variable "init_stderr" {
  type    = string
  default = "error"
}
variable "init_stdout" {
  type    = string
  default = "error"
}
variable "stderr" {
  type    = string
  default = "error"
}
variable "stdout" {
  type = list(any)
  default = [
    {
      id          = 1
      name        = "error"
      description = "error"
    }
  ]
}
