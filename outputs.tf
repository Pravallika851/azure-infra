output "workspace_url" {
  value = azurerm_databricks_workspace.this.workspace_url
}

output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}
