provider "azurerm" {
  #version = "=2.20.0"
  features {}
}

variable "datadisk" {
  type = object({
    a = string
    b = string
    c = string
  })
  default = {
    a            : "testdisk"
    b            : "newdisk"
    c            : "olddisk"
  }
}
resource "azurerm_resource_group" "example" {
  name     = "resourceGroup1"
  location = "West US"
}

resource "azurerm_managed_disk" "name" {
  for_each = var.datadisk

  name = format("%s-%s", each.value, each.key)
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_type = "StandardSSD_LRS"
  create_option = "Empty"
  disk_size_gb = "10"
}

