output "names" {
  description = "List of address resource names"
  value       = module.address.names
}

output "addresses" {
  description = "List of address values managed by this module"
  value       = module.address.addresses
}

output "dns_fqdns" {
  description = "List of DNS fully qualified domain names registered in Cloud DNS.  (e.g. [\"gusw1-dev-fooapp-fe-0001-a-001.example.com\", \"gusw1-dev-fooapp-fe-0001-a-0002.example.com\"])"
  value       = module.address.dns_fqdns
}

output "self_links" {
  description = "List of URIs of the created address resources"
  value       = module.address.self_links
}