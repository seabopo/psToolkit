#==================================================================================================================
#==================================================================================================================
# PoweerShell Module: psToolkit
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# INITIALIZATIONS
#==================================================================================================================

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $ErrorActionPreference = "Stop"

    Set-Variable -Scope 'Local' -Name "PS_MODULE_ROOT" -Value $PSScriptRoot
    Set-Variable -Scope 'Local' -Name "PS_MODULE_NAME" -Value $($PSScriptRoot | Split-Path -Leaf)

    $env:PS_STATUSMESSAGE_BANNER_STRING       = '='
    $env:PS_STATUSMESSAGE_BANNER_LENGTH       = 80
    $env:PS_STATUSMESSAGE_COLOR_BANNERS       = $false
    $env:PS_STATUSMESSAGE_INDENTATION_STRING  = '...'
    $env:PS_STATUSMESSAGE_MAX_RECURSION_DEPTH = 100
    $env:PS_STATUSMESSAGE_COLOR_DEBUG_OBJECTS = $false
    $env:PS_STATUSMESSAGE_IGNORE_PARAMS_JSON  = '["Invocation"]'

#==================================================================================================================
# LOAD FUNCTIONS AND EXPORT PUBLIC FUNCTIONS AND ALIASES
#==================================================================================================================

  # Define the root folder source lists for public and private functions
    $publicFunctionsRootFolders  = @('Public')
    $privateFunctionsRootFolders = @('Private')

  # Load all public functions
    $publicFunctionsRootFolders | ForEach-Object {
        Get-ChildItem -Path "$PS_MODULE_ROOT\$_\*.ps1" -Recurse | ForEach-Object { . $($_.FullName) }
    }

  # Export all the public functions and aliases (enable for teting only)
    # Export-ModuleMember -Function * -Alias *

  # Load all private functions
    $privateFunctionsRootFolders | ForEach-Object {
        Get-ChildItem -Path "$PS_MODULE_ROOT\$_\*.ps1" -Recurse | ForEach-Object { . $($_.FullName) }
    }
