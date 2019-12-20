#!/usr/bin/env pwsh

Param(
    [switch]$Verbose
)

. $PSScriptRoot/docker-dev-services.ps1 -Action Stop -Verbose:$Verbose
