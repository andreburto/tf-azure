# Code based on the following tutorials:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli
# https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-static-website-terraform?tabs=azure-cli
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

locals {

  index_file = "index.html"

  static_files = {
    "header.png" = "image/png",
    "${local.index_file}" = "text/html",
  }
}

# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.rg_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.rg_location
  name     = random_pet.rg_name.id
}

# Generate random value for the storage account name
resource "random_string" "storage_account_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_account" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = random_string.storage_account_name.result

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = local.index_file
  }
}

resource "azurerm_storage_blob" "files" {
  for_each               = local.static_files
  name                   = each.key
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = each.value
  source                 = "${path.module}/files/${each.key}"
}
