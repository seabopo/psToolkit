Function Write-ExceptionMessage {
    <#
    .DESCRIPTION
        Writes an exception message for a catch to the console.

    .PARAMETER ErrorObject
        REQUIRED. Alias: -e. The error object to log.

    .PARAMETER FunctionName
        REQUIRED. String. Alias: -n. The name of the function that caught the error.
    #>
    [OutputType([Void])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [Alias('e')] $ErrorObject,
        [Parameter()] [String] [Alias('n')] $FunctionName
    )

    $msg = New-Object System.Collections.Generic.List[System.String]

    $msg.Add( $('Unhandled Exception Error:') )
    $msg.Add( [System.Environment]::NewLine )
    $msg.Add( $('    Error Message: {0}'        -f $ErrorObject.Exception.Message) )
    $msg.Add( [System.Environment]::NewLine )
    $msg.Add( $('    Function: {0}, line: {1}.' -f $FunctionName, $ErrorObject.InvocationInfo.ScriptLineNumber) )
    $msg.Add( [System.Environment]::NewLine )
    $msg.Add( $('    Module:  {0}'              -f $PS_MODULE_NAME) )
    $msg.Add( [System.Environment]::NewLine )
    $msg.Add( $('    Module:  {0}'              -f $_.ScriptStackTrace) )

    Write-Host ( $msg -join '' ) -ForegroundColor Red

}
