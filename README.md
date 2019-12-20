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

- Clone or copy this repository locally, or download from [releases](https://github.com/iblazhko/docker-dev-services/releases/) page
- Create a service set file `service-sets/<set>.local.yaml` (there is a rule in `.gitignore` to exclude `.local.yaml` files from source control) 
- Review included services `service.yaml` definitions. If you need to change environment variables to a service, add file `.env/<service-name>-<version>.env`. Typically this would be used to change default credentials. See corresponding service `service.env` file for a reference.

It is recommented to organize sets by products / use cases. E.g. if Product1 us using ELK and MongoDB, and Product2 uses ELK, Postgres, and Redis, you may have following sets:

`product-sets/prod1.local.yaml`

```yaml
set: prod1
services:
  - elasticsearch-7.5
  - kibana-7.5
  - mongo-4.2
```

`product-sets/prod2.local.yaml`

```yaml
set: prod2
services:
  - elasticsearch-7.5
  - kibana-7.5
  - postgres-12.1
  - redis-5.0
```

**NOTE:** You can define multiple custom service sets, however it is only possible to use them one at a time. All services use same bridge network, so if a service is included in multiple sets, Docker Compose will allocate distinct names for the service in different sets, but they will still use same network port, so only one service can be active at a time that uses that port.

### Start

Start service set by name:

```bash
start.ps1 <set-name>
```

### Stop

Stop service set that was previously started by `start.ps1 <set-name>`.

```bash
stop.ps1
```
