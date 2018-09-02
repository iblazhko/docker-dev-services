@echo off

set DEV_SERVICES_DRIVE=%~d2
set DEV_SERVICES_DIR=%~dp0

%DEV_SERVICES_DRIVE%
cd %DEV_SERVICES_DIR%

call services-versions.cmd
call services-list.cmd

docker-compose -p %DOCKER_DEVSVC_PROJECT% %DOCKER_DEVSVC_COMPOSE_FILES% up -d
