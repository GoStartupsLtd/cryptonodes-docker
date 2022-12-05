To run:

<code>docker compose -f sentry.yml --env-file mainnet.env up</code>

The configuration files are located in heimdall/config.
Also mainnet.env contains some endpoints, the others are located in heimdall-config.toml

NOTE: max_open_connections is set to unlimited in config.toml by default.