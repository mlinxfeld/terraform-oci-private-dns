output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "dns_resolver" {
  value = data.oci_dns_resolvers.FoggyKitchenDNSResolvers.resolvers[0].id
}

output "dns_resolver2" {
  value = data.oci_core_vcn_dns_resolver_association.FoggyKitchenVCNDNSResolverAssociation
}