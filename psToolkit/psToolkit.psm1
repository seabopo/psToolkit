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

    $env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES    = '["Header","Process","Debug","Information"]'
    $env:PS_STATUSMESSAGE_LABEL_MESSAGE_TYPES      = '["Debug","Success","Warning","Failure","Error","Exception"]'
    $env:PS_STATUSMESSAGE_INDENTATION_STRING       = '...'
    $env:PS_STATUSMESSAGE_BANNER_STRING            = '-'
    $env:PS_STATUSMESSAGE_BANNER_LENGTH            = 80
    $env:PS_STATUSMESSAGE_MAX_RECURSION_DEPTH      = 100
    $env:PS_STATUSMESSAGE_IGNORE_PARAMS_JSON       = '["_Invocation"]'

  # $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES    = $true
  # $env:PS_STATUSMESSAGE_LABELS                   = $false
  # $env:PS_STATUSMESSAGE_TIMESTAMPS               = $false
  # $env:PS_STATUSMESSAGE_COLOR_BANNERS            = $false
  # $env:PS_STATUSMESSAGE_COLOR_DEBUG_OBJECTS      = $false
  # $env:PS_STATUSMESSAGE_USE_ALL_OUTPUT_STREAMS   = $false

  # $env:PS_PIPELINEOBJECT_LOGGING                 = $false
  # $env:PS_PIPELINEOBJECT_DONTLOGPARAMS           = $false
  # $env:PS_PIPELINEOBJECT_LOGVALUES               = $false
  # $env:PS_PIPELINEOBJECT_INCLUDECOMMONPARAMS     = $false

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
