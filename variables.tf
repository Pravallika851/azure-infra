variable "subscription_id" { type = string }
variable "tenant_id"       { type = string }
variable "client_id"       { type = string }
variable "client_secret"   { type = string }

variable "location"        { type = string  default = "Central India" }
variable "rg_name"         { type = string  default = "rg-dbx-vnet" }
variable "vnet_name"       { type = string  default = "vnet-dbx" }
variable "vnet_cidr"       { type = string  default = "10.10.0.0/16" }
variable "subnet_public_cidr" { type = string default = "10.10.0.0/24" }
variable "subnet_private_cidr" { type = string default = "10.10.1.0/24" }
