variable "location" {
   type = string 
   default = "North Europe"
   description = "The Azure location where all resources in this hptechudev should be created."
}
variable "prefix" {
   type = string 
   default = "HPTECHU0"
   description = "The prefix used for all resources used by this MPCS-2021-TECHU-DEV Account"
}
variable "vm_name" {
    type = string
}

variable "disk_name_1" {
    type = number
    default = 127
    description = "Disk C (GB)"
}

variable "disk_name_2" {
    type = number
    default = 32
    description = "Disk D (GB)"
}

variable "disk_name_3" {
    type = number
    default = 32
    description = "SQL Data disk (GB)"
}

variable "disk_name_4" {
    type = number
    default = 32
    description = "SQL Log disk (GB)"
}

###### IMAGE
variable "vm_win_storage_image_reference_publisher" {
   type = string
}

variable "vm_win_storage_image_reference_offer" {
   type = string
}

variable "vm_win_storage_image_reference_sku" {
   type = string
}

variable "vm_win_storage_image_reference_version" {
   type = string
}

#OS DISK
variable "vm_storage_os_disk_name" {
   type = string    
}

variable "vm_storage_os_disk_caching" {
   type = string    
}

variable "vm_storage_os_disk_create_option" {
   type = string    
}

variable "vm_storage_os_disk_managed_disk_type" {
   type = string      
}

variable "vm_storage_os_disk_size" {
   type = string    
}

variable "SQLDATAFILEPATH" {
   type = string    
}

variable "SQLLOGFILEPATH" {
   type = string    
}
variable "rgname" {
   type = string    
}
variable "vnet_name" {
   type = string    
}
