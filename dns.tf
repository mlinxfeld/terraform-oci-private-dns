resource "oci_dns_view" "FoggyKitchenDNSView" {
    provider       = oci.targetregion
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    scope          = "PRIVATE"
    display_name   = "FoggyKitchenDNSView"
}

resource "oci_dns_zone" "FoggyKitchenDNSZone" {
    provider       = oci.targetregion
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    name           = "fkdns.me"
    zone_type      = "PRIMARY"
    scope          = "PRIVATE"
    view_id         = oci_dns_view.FoggyKitchenDNSView.id
}

resource "oci_dns_rrset" "FoggyKitchenDNSRecordSetA" {
    provider       = oci.targetregion
    zone_name_or_id = oci_dns_zone.FoggyKitchenDNSZone.id
    domain          = oci_dns_zone.FoggyKitchenDNSZone.name
    rtype           = "A"
    scope           = "PRIVATE"
    view_id         = oci_dns_view.FoggyKitchenDNSView.id

    items {
      domain = oci_dns_zone.FoggyKitchenDNSZone.name
      rtype  = "A"
      rdata  = oci_core_instance.FoggyKitchenPrivateServer.private_ip
      ttl    = 30
    } 

}

resource "oci_dns_resolver" "FoggyKitchenDNSResolver" {
    provider     = oci.targetregion
    resolver_id  = data.oci_dns_resolvers.FoggyKitchenDNSResolvers.resolvers[0].id
    scope        = "PRIVATE"

    attached_views {
        view_id = oci_dns_view.FoggyKitchenDNSView.id
    }
}
