provider "azurerm" {
    features {
       key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    }
  
}

  resource "azurerm_resource_group" "Test1" {
      name = var.azure_name
      location = var.azure_location
  }


  resource "azurerm_virtual_network" "vn1"{
    name = "${var.azure_name}-vnet"
    address_space = [var.address_space]
    location = azurerm_resource_group.Test1.location
    resource_group_name = azurerm_resource_group.Test1.name
}

resource "azurerm_subnet" "sub1" {
    name = "${var.azure_name}-subnet"
    resource_group_name =   azurerm_resource_group.Test1.name
    virtual_network_name = azurerm_virtual_network.vn1.name
    address_prefixes =[var.address_prefixes]
}

resource "azurerm_network_interface" "interface1" {
    name = "${var.azure_name}-interface"
    location =  azurerm_resource_group.Test1.location
    resource_group_name = azurerm_resource_group.Test1.name

    ip_configuration {
      name = "${var.azure_name}-config"
      subnet_id = azurerm_subnet.sub1.id
      private_ip_address_allocation = var.private_ip_address_allocation
    }
  
}

resource "azurerm_windows_virtual_machine" "testvm1" {
  name = "${var.azure_name}-Vm1"
  resource_group_name = azurerm_resource_group.Test1.name
  location = azurerm_resource_group.Test1.location
  size = "Standard_F2"
  admin_username = "Dheeraj"
  admin_password = "Saikrishna1995#"
  network_interface_ids = [azurerm_network_interface.interface1.id]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2019-Datacenter"
    version = "latest"
  }

}
