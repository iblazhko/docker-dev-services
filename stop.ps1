#!/usr/bin/env pwsh

Param(
    [ValidateNotNullOrEmpty()]
    [string]$Set = 'default',

    [switch]$Verbose
)

. $PSScriptRoot/docker-dev-services.ps1 -Set $Set -Action Stop -Verbose:$Verbose
