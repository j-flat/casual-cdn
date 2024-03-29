variable "machine_name" { default = "main-cdn-server" }
variable "machine_type" { default = "g1-small" }
variable "image" { default = "centos-cloud/centos-7" }
variable "region" { default = "europe-north1" }
variable "zone" { default = "europe-north1-a" }
variable "boot_disk_size" { default = "20" }