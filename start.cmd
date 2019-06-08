@echo off

REM Working directory must be the directory of this script
set DEV_SERVICES_DRIVE=%~d2
set DEV_SERVICES_DIR=%~dp0

%DEV_SERVICES_DRIVE%
cd %DEV_SERVICES_DIR%

REM Variables
call services-versions.cmd
call services-list.cmd

REM Ensure .env.local files exist
for %%f in (*.env) do (
    type nul>> %%~nf.env.local
)

REM Start services
docker-compose -p %DOCKER_DEVSVC_PROJECT% %DOCKER_DEVSVC_COMPOSE_FILES% up -d
