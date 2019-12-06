#!/usr/bin/env pwsh

Param(
    [ValidateNotNullOrEmpty()]
    [string]$Set = "default"
)

#######################################################################
# SHARED VARIABLES

$scriptDir = $PSScriptRoot
$serviceSetDir = Join-Path $scriptDir "service-sets" $Set
$serviceSetDefinition = Join-Path $serviceSetDir "services.yaml"

#######################################################################
# PARAMETERS VALIDATION

if (-Not $(Test-Path $serviceSetDir)) {
    Write-Host -ForegroundColor Red "Service set directory does not exist: $serviceSetDir"
    Exit 1
}
if (-Not $(Test-Path $serviceSetDefinition)) {
    Write-Host -ForegroundColor Red "Service set definition does not exist: $serviceSetDefinition"
    Exit 1
}

#######################################################################
# READ THE SET DEFINITION

#######################################################################
# PREPARE THE DOCKER-COMPOSE PARAMETERS

#######################################################################
# START THE SET

$currentLocation = Get-Location
try {
    Set-Location $serviceSetDir
    Write-Host -ForegroundColor Green "Starting service set $Set"
# docker-compose -p $DOCKER_DEVSVC_PROJECT $DOCKER_DEVSVC_COMPOSE_FILES up -d
    Write-Host -ForegroundColor Green "Done"
}
finally {
    Set-Location $currentLocation
}


