resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "public" {
  name                 = "databricks-public"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_public_cidr]
}

resource "azurerm_subnet" "private" {
  name                 = "databricks-private"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_private_cidr]
}

resource "azurerm_network_security_group" "public" {
  name                = "nsg-dbx-public"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_group" "private" {
  name                = "nsg-dbx-private"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet_network_security_group_association" "public_assoc" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

resource "azurerm_subnet_network_security_group_association" "private_assoc" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private.id
}

resource "azurerm_databricks_workspace" "this" {
  name                = "adb-vnet-hyd"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "premium"

  custom_parameters {
    vnet_id           = azurerm_virtual_network.this.id
    public_subnet_id  = azurerm_subnet.public.id
    private_subnet_id = azurerm_subnet.private.id
  }
}

resource "databricks_cluster" "basic" {
  cluster_name            = "starter-cluster"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = "Standard_DS2_v2"   # smaller VM
  num_workers             = 1                   # minimal worker count
  autotermination_minutes = 15                  # auto-shutdown
}
