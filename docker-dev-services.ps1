#!/usr/bin/env pwsh

Param(
    [ValidateNotNullOrEmpty()]
    [string]$Set = 'default',

    [ValidateNotNullOrEmpty()]
    [string]$Action = 'Start',

    [switch]$Verbose
)

#######################################################################
# SHARED VARIABLES

$rootDir = $PSScriptRoot
$serviceSetDefinition = Join-Path $rootDir 'service-sets' "$Set.yaml"

if ($Verbose) {
    Write-Host -ForegroundColor DarkGray "Root directory: $rootDir"
    Write-Host -ForegroundColor DarkGray "Service set definition file: $serviceSetDefinition"
    Write-Host -ForegroundColor DarkGray "Action: $Action"
}

#######################################################################
# PARAMETERS VALIDATION

if (-Not $(Test-Path $serviceSetDefinition)) {
    Write-Host -ForegroundColor Red "Service set definition does not exist: $serviceSetDefinition"
    Exit 1
}

#######################################################################
# READ THE SET DEFINITION
if (-not $(Get-Module | Where-Object -Property Name -eq -Value 'powershell-yaml')) {
    if (-not $(Get-InstalledModule | Where-Object -Property Name -eq -Value 'powershell-yaml')) {
        Install-Module powershell-yaml -Force
    }
    Import-Module powershell-yaml -Force
}

$services = Get-Content $serviceSetDefinition -Raw | ConvertFrom-Yaml

if ($Verbose) {
    Write-Host -ForegroundColor DarkGray "Service set definition content:"
    Write-Host -ForegroundColor DarkGray $($services | ConvertTo-Yaml)
}

if (-not $services.set) {
    Write-Host -ForegroundColor Red "Service set name is not defined in $serviceSetDefinition"
    Exit 1
}

if (-not $($services.services.Length -gt 0)) {
    Write-Host -ForegroundColor Red "No services defined in $serviceSetDefinition"
    Exit 1
}

#######################################################################
# PREPARE THE DOCKER-COMPOSE PARAMETERS

$composeArguments = '-p', $services.set, '-f', 'services/network.yaml'
foreach ($x in $services.services) {
    $composeArguments = $composeArguments + '-f' + "services/$x/service.yaml"
}

#######################################################################
# ENSURE .ENV FILES EXIST

$localEnvDir = Join-Path $rootDir '.env'
if (-not $(Test-Path $localEnvDir)) {
    if ($Verbose) { Write-Host -ForegroundColor DarkGray "Creating $localEnvDir" }
    New-Item -Path $localEnvDir -ItemType Directory | Out-Null
}

foreach ($x in $services.services) {
    $localServiceEnv = Join-Path $localEnvDir "$x.env"
    if (-not $(Test-Path $localServiceEnv)) {
        if ($Verbose) { Write-Host -ForegroundColor DarkGray "Creating $localServiceEnv" }
        New-Item -Path $localServiceEnv -ItemType File | Out-Null
    }
}

#######################################################################
# ENTRY POINT

if ($Action -eq 'Start') { $composeArguments = $composeArguments + 'up' + '-d' }
if ($Action -eq 'Stop') { $composeArguments = $composeArguments + 'down' }

$currentLocation = Get-Location
try {
    Set-Location $rootDir
    if ($Verbose) { Write-Host -ForegroundColor DarkGray "docker-compose $composeArguments" }
    Start-Process -FilePath "docker-compose" -ArgumentList $composeArguments -WorkingDirectory $rootDir -NoNewWindow -Wait
    Write-Host -ForegroundColor Green "Done"
}
finally {
    Set-Location $currentLocation
}
