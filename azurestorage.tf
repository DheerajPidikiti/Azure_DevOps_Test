resource "azurerm_storage_account" "name" {
    name = "${var.azure_name}-storage1"
    resource_group_name = azurerm_resource_group.Test1.name
    location = azurerm_resource_group.Test1.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

}

