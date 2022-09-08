output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "public_server_public_ip_address" {
  value     = oci_core_instance.FoggyKitchenPublicServer.public_ip
}

output "public_server_private_ip_address" {
  value     = oci_core_instance.FoggyKitchenPublicServer.private_ip
}

output "public_server_dns_name" {
  value     = "${var.public_server_domain_name}.${var.dns_domain}"
}

output "private_server_ip_address" {
  value     = oci_core_instance.FoggyKitchenPrivateServer.private_ip
}

output "private_server_dns_name" {
  value     = "${var.private_server_domain_name}.${var.dns_domain}"
}
