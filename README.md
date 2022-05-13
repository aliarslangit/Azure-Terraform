# Terraform

Terraform is an open-source infrastructure as code software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language.


**Installation:**

Terraform can be installed and used on Windows, Mac and all major OS distributions of Linux.
Please refer following link for Terraform installation.
https://learn.hashicorp.com/tutorials/terraform/install-cli

**About**

This repository includes terraform scripts for all major and widely used Azure services and can be re-used to deploy Azure environments.
All Terraform scripts are parameterized which can be configured in variables.tf file.

## Key Concepts of Terraform

- Input Variables — Serve as parameters for a Terraform module, so users can customize behavior without editing the source
- Modules — Acts as a container for multiple resources that are used together. It is a way to package and reuse resource configurations.
- Resources — Documents the syntax for declaring resources
- Data sources — Allow data to be fetched or computed for use elsewhere in Terraform configuration
- Output values — Return values for a Terraform module
- Local values — A convenience feature for assigning a short name to an expression

## Life-Cycle of Terraform
- terraform init :Initializes the working directory which consists of all the configuration files. The terraform init command creates a working directory in which Terraform configuration files can be found.
- terraform validate : Validates the configuration files in a directory. terraform validate to make sure that your code is valid. If there are any errors in the syntax or missing data, this will display that.
- terraform plan — Creates an execution plan to reach a desired state of the infrastructure. We can run terraform plan to see the execution plan. This is a fantastic way to double-check the changes before executing them. If you don’t specify any VPC, subnet IDs, this configuration will create the resources in the default VPC with respective default values.
- terraform apply — Makes the changes in the infrastructure as defined in the plan. To actually create the resources, run terraform apply.

> Note: Terraform stores information about your infrastructure in a state file. This state file keeps track of resources created by your configuration and maps them to real-world resources. It's highly important to store and maintain state file wither on local directory or on cloud storage such as azure blob.


## Simple Usage 

You may clone the repo and use any of the scripts with bare minimum configurations to provision instances of respective services on your Azure environment.
for authentication you can either use 'az login' or configure service principal in variables.tf file.

```hcl
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
```

#### Prerequisites

- [Terraform exe](https://www.terraform.io/downloads)
- [Azure subscription](https://portal.azure.com/)


## Authors

Created by [Ali Arslan](https://github.com/aliarslangit)





