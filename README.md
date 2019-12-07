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

- Docker with Docker Compose: <https://docs.docker.com/install/>
- PowerShell Core: <https://github.com/powershell/powershell>

## Overview

Set of services is started using Docker Compose.

Each service in the set is defined in its own directory `services/<service-name>-<version>/service.yaml`.

All services use bridge network `devsvcnet` (defined in `services/network.yaml`), so they are immediately available on the host machine.

Sets are defined in `service-set/set.yaml` files. There are two sets provided out of the box:

- `default`
- `_template`: this set has all the supported services included and can be used as a starting point when creating own sets

## Usage

- Clone or copy this repository locally
- Create a service set file `service-sets/<set>.local.yaml` (there is a rule in `.gitignore` to exclude `.local.yaml` files from source control) 
- Review include services `service.yaml` definitions. If you need to change environment variables to a service, add file `.env/<service-name>-<version>.env`. Typically this would be used to change default credentials.

### Start

```bash
start.ps1 -Set <set-name>
```

### Stop

```bash
stop.ps1 -Set <set-name>
```
