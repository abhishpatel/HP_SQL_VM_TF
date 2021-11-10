resource "azurerm_resource_group" "hptechudev" {
  name     = var.rgname
  location = var.location
  tags = {
    Environment = "Dev"
    Owner = "charles.v.pardue@hp.com"
    "Cost Center" = "US98030324"
    "Location Code" = "1100677700000000"
    Criticality = "Normal"
    Category = "DEV+Normal"
  }
}
resource "azurerm_virtual_network" "hptechudev" {
  name                = var.vnet_name
  address_space       = ["10.240.10.0/24"]
  location            = azurerm_resource_group.hptechudev.location
  resource_group_name = azurerm_resource_group.hptechudev.name
  tags = {
    Environment = "Dev"
    Owner = "charles.v.pardue@hp.com"
    "Cost Center" = "US98030324"
    "Location Code" = "1100677700000000"
    Criticality = "Normal"
    Category = "DEV+Normal"
  }
}
resource "azurerm_subnet" "hptechudev" {
  name                 = "${var.prefix}-SN"
  resource_group_name  = azurerm_resource_group.hptechudev.name
  virtual_network_name = azurerm_virtual_network.hptechudev.name
  address_prefixes     = ["10.240.10.0/24"]
}
resource "azurerm_network_security_group" "hptechudev" {
  name                = "${var.prefix}-NSG"
  location            = azurerm_resource_group.hptechudev.location
  resource_group_name = azurerm_resource_group.hptechudev.name
}
# resource "azurerm_network_security_rule" "RDPRule" {
#   name                        = "RDPRule"
#   resource_group_name         = azurerm_resource_group.hptechudev.name
#   priority                    = 1000
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = 3389
#   source_address_prefix       = "10.240.10.100/24"
#   destination_address_prefix  = "*"
#   network_security_group_name = azurerm_network_security_group.hptechudev.name
# }
# resource "azurerm_network_security_rule" "MSSQLRule" {
#   name                        = "MSSQLRule"
#   resource_group_name         = azurerm_resource_group.hptechudev.name
#   priority                    = 1001
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = 1433
#   source_address_prefix       = "10.240.10.100/24"
#   destination_address_prefix  = "*"
#   network_security_group_name = azurerm_network_security_group.hptechudev.name
# }
# resource "azurerm_subnet_network_security_group_association" "hptechudev" {
#   subnet_id                 = azurerm_subnet.hptechudev.id
#   network_security_group_id = azurerm_network_security_group.hptechudev.id
# }
# resource "azurerm_public_ip" "vm" {
#   name                = "${var.prefix}-PIP"
#   location            = azurerm_resource_group.hptechudev.location
#   resource_group_name = azurerm_resource_group.hptechudev.name
#   allocation_method   = "Static"
# }
resource "azurerm_network_interface" "hptechudev" {
  name                = "${var.prefix}-NIC"
  location            = azurerm_resource_group.hptechudev.location
  resource_group_name = azurerm_resource_group.hptechudev.name
  ip_configuration {
    name                          = "hptechudevconfiguration1"
    subnet_id                     = azurerm_subnet.hptechudev.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.240.10.100"
    //public_ip_address_id          = azurerm_public_ip.vm.id
  }
  tags = {
    Environment = "Dev"
    Owner = "charles.v.pardue@hp.com"
    "Cost Center" = "US98030324"
    "Location Code" = "1100677700000000"
    Criticality = "Normal"
    Category = "DEV+Normal"
  }
}
# resource "azurerm_network_interface_security_group_association" "hptechudev" {
#   network_interface_id      = azurerm_network_interface.hptechudev.id
#   network_security_group_id = azurerm_network_security_group.hptechudev.id
# }
resource "azurerm_virtual_machine" "hptechudev" {
  name                  = var.vm_name
  location              = azurerm_resource_group.hptechudev.location
  resource_group_name   = azurerm_resource_group.hptechudev.name
  network_interface_ids = [azurerm_network_interface.hptechudev.id]
  vm_size               = "Standard_D2s_v3"
  # Image reference
  storage_image_reference {
    publisher = var.vm_win_storage_image_reference_publisher   
    offer     = var.vm_win_storage_image_reference_offer       
    sku       = var.vm_win_storage_image_reference_sku         
    version   = var.vm_win_storage_image_reference_version     
  }
  # OS disk
  storage_os_disk {
    name              = var.vm_storage_os_disk_name
    caching           = var.vm_storage_os_disk_caching   
    create_option     = var.vm_storage_os_disk_create_option   
    managed_disk_type = var.vm_storage_os_disk_managed_disk_type
    disk_size_gb      = var.vm_storage_os_disk_size
  }
  os_profile {
    computer_name  = "HPTECHU0"
    admin_username = "hptechudevadmin"
    admin_password = "Password1234!"
  }
  os_profile_windows_config {
    timezone                  = "Pacific Standard Time"
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
storage_data_disk {
  name              = "Data-Disk-1"
  caching           = "ReadWrite"
  create_option     = "Empty"
  disk_size_gb      = 32
  lun               = 1
  managed_disk_type = "Premium_LRS"
}
storage_data_disk {
  name              = "SQL-Data-Disk-2"
  caching           = "ReadWrite"
  create_option     = "Empty"
  disk_size_gb      = 32
  lun               = 2
  managed_disk_type = "Premium_LRS"
}
storage_data_disk {
  name              = "SQL-Log-Disk"
  caching           = "ReadWrite"
  create_option     = "Empty"
  disk_size_gb      = 32
  lun               = 3
  managed_disk_type = "Premium_LRS"
}  
tags = {
    Environment = "Dev"
    Owner = "charles.v.pardue@hp.com"
    "Cost Center" = "US98030324"
    "Location Code" = "1100677700000000"
    Criticality = "Normal"
    Category = "DEV+Normal"
  }
}
resource "azurerm_mssql_virtual_machine" "hptechudev" {
    virtual_machine_id = azurerm_virtual_machine.hptechudev.id
    sql_license_type   = "PAYG"
    sql_connectivity_port            = 1433
    sql_connectivity_type            = "PRIVATE"
    sql_connectivity_update_password = "Password1234!"
    sql_connectivity_update_username = "hptechudevadmin"
#  auto_patching {
#    day_of_week                            = "Sunday"
#    maintenance_window_duration_in_minutes = 60
#    maintenance_window_starting_hour       = 2
#  }
    storage_configuration{
        disk_type             = "NEW"
        storage_workload_type = "OLTP"
    data_settings {
        default_file_path = var.SQLDATAFILEPATH 
        luns              = [1, 2]              
     }
    log_settings {
        default_file_path = var.SQLLOGFILEPATH
        luns              = [3]                
        }
    }
}