resource "oci_core_vcn" "FoggyKitchenVCN" {
  provider       = oci.targetregion
  cidr_block     = lookup(var.network_cidrs, "VCN-CIDR")
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenVCN"
  dns_label      = "fkvcn"
}

resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
  provider       = oci.targetregion
  block_traffic  = "false"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenNATGateway"
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
}

resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  provider       = oci.targetregion
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenInternetGateway"
  enabled        = true
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
}

resource "oci_core_route_table" "FoggyKitchenVCNPrivateRouteTable" {
  provider       = oci.targetregion
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenVCNPrivateRouteTable"
  route_rules {
    description       = "Traffic to the internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
  }
}

resource "oci_core_route_table" "FoggyKitchenVCNPublicRouteTable" {
  provider       = oci.targetregion
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenVCNPublicRouteTable"

  route_rules {
    description       = "Traffic to/from internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.FoggyKitchenInternetGateway.id
  }
}

resource "oci_core_subnet" "FoggyKitchenPublicSubnet" {
  provider                   = oci.targetregion
  cidr_block                 = lookup(var.network_cidrs, "PUBLIC-SUBNET-REGIONAL-CIDR")
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name               = "FoggyKitchenPublicSubnet"
  dns_label                  = "pubsub"
  vcn_id                     = oci_core_vcn.FoggyKitchenVCN.id
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.FoggyKitchenVCNPublicRouteTable.id
  dhcp_options_id            = oci_core_vcn.FoggyKitchenVCN.default_dhcp_options_id
}

resource "oci_core_subnet" "FoggyKitchenPrivateSubnet" {
  provider                   = oci.targetregion
  cidr_block                 = lookup(var.network_cidrs, "PRIVATE-SUBNET-REGIONAL-CIDR")
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name               = "FoggyKitchenPrivateSubnet"
  dns_label                  = "privsub"
  vcn_id                     = oci_core_vcn.FoggyKitchenVCN.id
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.FoggyKitchenVCNPrivateRouteTable.id
  dhcp_options_id            = oci_core_vcn.FoggyKitchenVCN.default_dhcp_options_id
}

