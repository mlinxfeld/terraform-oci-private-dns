
resource "oci_dns_view" "FoggyKitchenDNSView" {
    count          = var.enable_private_DNS ? 1 : 0
    provider       = oci.targetregion
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    scope          = "PRIVATE"
    display_name   = "FoggyKitchenDNSView"
}

resource "oci_dns_zone" "FoggyKitchenDNSZone" {
    count          = var.enable_private_DNS ? 1 : 0
    provider       = oci.targetregion
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    name           = var.dns_domain
    zone_type      = "PRIMARY"
    scope          = "PRIVATE"
    view_id         = oci_dns_view.FoggyKitchenDNSView[count.index].id
}

resource "oci_dns_rrset" "FoggyKitchenDNSRecordSetA" {
    count           = var.enable_private_DNS ? 1 : 0
    provider        = oci.targetregion
    zone_name_or_id = oci_dns_zone.FoggyKitchenDNSZone[count.index].id
    domain          = oci_dns_zone.FoggyKitchenDNSZone[count.index].name
    rtype           = "A"
    scope           = "PRIVATE"
    view_id         = oci_dns_view.FoggyKitchenDNSView[count.index].id

    items {
      domain = oci_dns_zone.FoggyKitchenDNSZone[count.index].name
      rtype  = "A"
      rdata  = oci_core_instance.FoggyKitchenPrivateServer.private_ip
      ttl    = 30
    } 

}

resource "oci_dns_resolver" "FoggyKitchenDNSResolver" {
    count        = var.enable_private_DNS ? 1 : 0
    depends_on   = [oci_core_vcn.FoggyKitchenVCN]
    provider     = oci.targetregion
    resolver_id  = data.oci_dns_resolvers.FoggyKitchenDNSResolvers.resolvers[0].id
    scope        = "PRIVATE"

    attached_views {
        view_id = oci_dns_view.FoggyKitchenDNSView[count.index].id
    }
}


