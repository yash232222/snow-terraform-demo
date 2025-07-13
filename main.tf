terraform {

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~>2.3.0"
    }
  }
}

variable "snow_password" {
  type      = string
  sensitive = true
}

variable "snow_user" {
  type = string
}

variable "snow_account" {
  type = string
}

variable "snow_org" {
  type = string
}

variable "snow_db" {
  type    = string
  default = "iac_db"
}

variable "snow_role" {
  type    = string
  default = "iac_db"
}

provider "snowflake" {
  account_name  = var.snow_account
  organization_name = var.snow_org
  user          = var.snow_user
  password      = var.snow_password
  role          = var.snow_role
  authenticator = "Snowflake"
  preview_features_enabled = ["snowflake_table_resource"]
}

resource "snowflake_table" "table" {
  database = var.snow_db
  schema   = "PUBLIC"
  name     = "trr_table"
  column {
    name = "id"
    type = "int"
  }
  column {
    name = "name"
    type = "varchar(30)"
  }
}

