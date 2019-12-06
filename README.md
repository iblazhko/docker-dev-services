# Docker Dev Services

## Description

This is a set of scripts to run set of services during development using
Docker Compose. Makes it easier to start / stop set of services on demand.

Supported services:

- ELK stack (Elasticsearch + Logstash + Kibana)
- EventStore
- MongoDB
- PostgreSQL
- RabbitMQ
- Redis
- SQL Server
- Vault

## Prerequisites

- Docker with Docker Compose
- PowerShell Core

## Usage

Review `<service>.yaml` files, you may want to make some adjustments e.g.
mounted data volume path etc.

You will also find `compose-<service>.env` files for some of the services. This
is where devault environment variables are defined. If you need to change
service's environment variables, create `compose-<service>.env.local` file and
put your environment variables there. `compose-<service>.env.local` files are
local and should not be checked into source control (there is a rule in
`.gitignore` to help with that).

### Linux, macOS

Review `services-versions.sh`, adjust version numbers if needed.

Review `services-list.sh`, adjust list of services that will be started.

Start all the services:

```bash
start.sh
```

Stop all the services and remove containers:

```bash
stop.sh
```

### Windows

Review `services-versions.cmd`, adjust version numbers if needed.

Review `services-list.cmd`, adjust list of services that will be started.

Start all the services:

```bash
start.cmd
```

Stop all the services and remove containers:

```bash
stop.cmd
```
