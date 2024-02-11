# variables
#

variable "prefix" {}

variable "region" {}
variable "zone" {}
variable "project" {}

# Resource tag labels
variable "owner" {}
variable "expires_on" {}
variable "slack_owner" {}
variable "purpose" {}

variable "instance_count" {}
variable "instance_type" {}

# Private/internal instance CIDR
variable "subnetCIDRblock" {
  default = "10.2.0.0/16"
}

# Firewall allow CIDRs
variable "myCIDR" {}
variable "myTravelCIDR" {}

# Allow gcp IAP access
variable "gcpIAPCIDR" {
  default = "35.235.240.0/20"
}

# ssh user
variable "my_ssh_user" {}
variable "my_ssh_pub_key_file" {}

# Instance config
variable "os_image" {}
variable "boot_disk_size_gb" {
  default = "153"
}
variable "boot_disk_type" {
  default = "pd-standard"
}

