# Docker Dev Services

## Description

This is a set of scripts to run services used in development with
Docker Compose.

Supported services:

- ELK stack (Elasticsearch + Logstash + Kibana)
- MongoDB
- RabbitMQ
- Redis
- EventStore
- SQL Server
- PostgreSQL
- Vault

## Prerequisites

- Docker with Docker Compose

## Usage

Review `<service>.yaml` files, you may want to make some adjustments e.g. mounted data volume path etc.
If you need to change service's environment variables, create `compose-<service>.env.local` file and put your environment variables there. Default environment variables are defined in `compose-<service>.env` file, use that as an example. `compose-<service>.env.local` files are local and should not be checked into source control (there is a rule in `.gitignore` to help with that).


### Linux, macOS

Review `services-versions.sh`, adjust version numbers if needed.

Review `services-list.sh`, adjust list of services that will be started.

Start all the services:

```
start.sh
```

Stop all the services and remove containers:

```
stop.sh
```

### Windows


Review `services-versions.cmd`, adjust version numbers if needed.

Review `services-list.cmd`, adjust list of services that will be started.

Start all the services:

```
start.cmd
```

Stop all the services and remove containers:

```
stop.cmd
```
