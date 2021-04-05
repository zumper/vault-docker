## vault-docker

This Docker Compose file sets up a three-node Consul cluster and a corresponding three-node Vault
cluster. It uses localstack to retrieve the auto-unseal key for the Vault cluster.

## Getting Started
1. Clone this repo
2. Run the repo with `docker-compose up`
3. Copy the root vault key from the output of `docker-compose logs vault1`
4. Paste the root vault key into the `invoke_failovers.sh` script on the line setting the
`VAULT_TOKEN`.
5. Run the `./invoke_failovers.sh`.