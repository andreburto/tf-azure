# Azure Static Web Page

## About

This site configuration is based off the following tutorials:

* [Azure Provider: Authenticating using the Azure CLI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)
* [Quickstart: Deploy a static website on Azure Storage using Terraform](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-static-website-terraform?tabs=azure-cli)

## Requirements

* [Azure account](https://azure.microsoft.com/en-us/free/search/)
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
* [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)

## Usage

1. Login to Azure with the `az login` command so that it outputs the tenant and subscription IDs.
2. Create a `terraform.tfvars` file and set the two variables `tenant_id` and `subscription_id`.
3. Modify the `index.html` and `header.png` files as desired.
4. Once set, use `terraform plan` and `terraform apply -auto-approve` to setup the site.
5. Use the output URL to visit your new site.
