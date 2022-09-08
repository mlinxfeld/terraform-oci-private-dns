data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}


data "oci_identity_availability_domains" "ADs" {
  provider       = oci.targetregion
  compartment_id = var.tenancy_ocid
}

# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID" {
  provider                 = oci.targetregion
  compartment_id           = oci_identity_compartment.FoggyKitchenCompartment.id
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.shape


  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_dns_resolvers" "FoggyKitchenDNSResolvers" {
    provider       = oci.targetregion
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    scope          = "PRIVATE"
}

data "oci_core_vcn_dns_resolver_association" "FoggyKitchenVCNDNSResolverAssociation" {
    count    = var.enable_private_DNS ? 1 : 0
    provider = oci.targetregion
    vcn_id   = oci_core_vcn.FoggyKitchenVCN.id
}