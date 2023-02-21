## Cryptonodes Docker

This repository features Docker files for several blockchain nodes, utilizing multi-stage builds in select cases to optimize image size. This approach balances the advantages of reduced file size with the potential challenges of increased complexity.

## Prerequisites:
- Docker version <b>19.03</b> or higher
- Sufficient disk space to store the blockchain data for each node

## Setup:

1. Clone the repository
```bash
git clone https://github.com/GoStartupsLtd/cryptonodes-docker.git
```

2. Navigate into the repository directory:
```bash
cd cryptonodes-docker
```

3. Choose a node and build its Docker image:
```bash
cd <node-name>
docker build -t <node-name> .
```

## Configuration:

Each node's Docker image has its own configuration options, which can be customized by editing the environment variables in the run script located at `./node-name/run.sh` before building the node.

## Usage:

1. Start a new container for the selected node:
```bash
docker run -d --name <node-name> -p <node-port>:<node-port> <node-name>
```

1. Connect to the node and perform necessary tasks. The specific method for interacting with the node will depend on the node.

## Maintenance:

- To update a node, simply rebuild its Docker image.
- To back up a node's data, copy its data directory to a secure location. To restore the data, copy the directory back into the container.

## Troubleshooting:

- If the node is not syncing with the network, try increasing its maximum inbound connections.
- If the node's RPC is inaccessible, verify that the correct ports are exposed and that the RPC credentials are correct.

## Contributing:

We welcome contributions to this repository! To add a new node, please follow the code style of the repository and provide comprehensive documentation.

To contribute to this repository, you will need to:

To contribute, follow these steps:

1. Fork the repository
2. Make changes to your forked repository
3. Submit a Pull Request (PR) to the main repository, explaining your changes and why they are needed.
4. Our team will review your contribution and merge it into the main repository if it is accepted.