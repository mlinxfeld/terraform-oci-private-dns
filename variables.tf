variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

variable "availability_domain_name" {
  default = ""
}

variable "enable_private_DNS" {
  default = false
}

variable "dns_domain" {
  default = "fkdns.me"
}

variable "dns_a_record_ttl" {
  default = 30
}

variable "public_server_domain_name" {
  default = "foggykitchenpublicserver"
}

variable "private_server_domain_name" {
  default = "foggykitchenprivateserver"
}

variable "network_cidrs" {
  type = map(string)

  default = {
    VCN-CIDR                     = "10.20.0.0/16"
    PUBLIC-SUBNET-REGIONAL-CIDR  = "10.20.10.0/24"
    PRIVATE-SUBNET-REGIONAL-CIDR = "10.20.20.0/24"
  }
}

variable "shape" {
  default = "VM.Standard.E4.Flex"
}

variable "flex_shape_memory" {
  default = 8
}

variable "flex_shape_ocpus" {
  default = 1
}

variable "instance_os" {
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  default     = "8"
}