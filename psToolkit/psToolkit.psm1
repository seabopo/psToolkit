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

    if ($IsWindows) { $lineBreak = "`r`n" } else { $lineBreak = "`n" }

    Set-Variable -Scope 'Local' -Name "PS_MODULE_ROOT"      -Value $PSScriptRoot
    Set-Variable -Scope 'Local' -Name "PS_MODULE_NAME"      -Value $($PSScriptRoot | Split-Path -Leaf)

    Set-Variable -Scope 'Local' -Name "PS_EXCEPTION_MSG"    -Value $( "Unhandled Exception Error: " + $lineBreak +
                                                                      "    Error Message: {0}" + $lineBreak +
                                                                      "    Function: {1}, line: {2}." + $lineBreak +
                                                                      "    Module: " + $PS_MODULE_NAME + $lineBreak +
                                                                      "{3}")

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
