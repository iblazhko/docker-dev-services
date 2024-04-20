#!/usr/bin/env pwsh

Param(
    [ValidateNotNullOrEmpty()]
    [string]$Set = 'default',

    [ValidateNotNullOrEmpty()]
    [ValidateSet('docker', 'podman')]
    [string]$Engine = 'docker',

    [switch]$Verbose
)

. $PSScriptRoot/docker-dev-services.ps1 -Set $Set -Action Start -Engine $Engine -Verbose:$Verbose
