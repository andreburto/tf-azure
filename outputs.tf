output "primary_web_host" {
  value = "https://${azurerm_storage_account.storage_account.primary_web_host}/"
}
