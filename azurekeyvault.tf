data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "name" {
    name = "${var.azure_name}-keyVault"
    location = var.azure_location
    resource_group_name = azurerm_resource_group.Test1.name
    tenant_id = data.azurerm_client_config.current.tenant_id
    sku_name = "standard"
}

