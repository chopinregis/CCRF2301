resource "azurerm_resource_group" "vm_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
}

resource "azurerm_subnet" "my_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.vm_rg.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes       = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "my_nic" {
  count               = length(var.vm_config)
  name                = "${var.vm_config["vms"][count.index]["name"]}NIC"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "myvms" {
  count                = length(local.vm_config)
  name                 = var.vm_config[count.index]["name"]
  location             = azurerm_resource_group.vm_rg.location
  resource_group_name  = azurerm_resource_group.vm_rg.name
  network_interface_ids = [azurerm_network_interface.my_nic[count.index].id]
  vm_size              = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${local.vm_config[count.index]["name"]}OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = local.vm_config[count.index]["name"]
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
