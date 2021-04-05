# /etc/.d/server.hcl
# Managed by Salt

storage "consul" {
	address = "consul3:8500"
	path    = "vault/"
}

listener "tcp" {
    address         = "172.30.0.23:8200"
    cluster_address = "172.30.0.23:8201"
    tls_disable     = 1
}

seal "awskms" {
    kms_key_id = "bc436485-5092-65442b8-92a3-0aa8b93536dc"
    region     = "us-west-2"
}

ui = "true"

log_level = "trace"

# NOTE: DO NOT change api_addr to use hostnames!
#
# Consul 1.6.1 does not support recursive DNS lookups. If this is set to a non-IP value
# when a lookup for vault.service.consul reaches Consul's DNS server, Consul will will then
# resolve a CNAME to a Vault server's hostname, which it will then not be able to resolve itself
# to an IP address and result in a DNS resolution failure, even though the service will appear
# healthy in Consul!
api_addr = "https://vault3:8200"
