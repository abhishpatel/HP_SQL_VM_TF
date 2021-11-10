  #RG NAME
  rgname = "RGTechU"
  vnet_name = "VNetTechU"
  prefix = "TechU"

  #Location
  location = "North Europe"
  
  #VM NAME
  vm_name = "HPTECHU0"

#IMAGE
  vm_win_storage_image_reference_publisher = "MicrosoftSQLServer"
  vm_win_storage_image_reference_offer     = "sql2019-ws2019"
  vm_win_storage_image_reference_sku       = "standard"
  vm_win_storage_image_reference_version   = "latest"

# OS DISK
vm_storage_os_disk_name = "sql-vm-os"
vm_storage_os_disk_caching = "ReadWrite"
vm_storage_os_disk_managed_disk_type = "Premium_LRS"
vm_storage_os_disk_create_option = "FromImage"
vm_storage_os_disk_size = "127"

SQLDATAFILEPATH = "X:\\Data"
SQLLOGFILEPATH = "Y:\\TLog"