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

    $errorMessage = $( 'Exception Error:'             ) + [System.Environment]::NewLine +
                    $('    Module: {0}'               ) + [System.Environment]::NewLine +
                    $('    Function: {1}, line: {2}'  ) + [System.Environment]::NewLine +
                    $('    Error Message: {3}'        ) + [System.Environment]::NewLine +
                    $('    Code Statement: {4}'       ) + [System.Environment]::NewLine +
                    $('    Stack Trace: {5}'          ) + [System.Environment]::NewLine +
                    $('    PowerShell: {6} {7} on {8}')

    $statement = $MessageObject.DebugObject.InvocationInfo.Statement ??
                 $MessageObject.DebugObject.InvocationInfo.Line ??
                 '<Not available>'

    $stack = $MessageObject.DebugObject.ScriptStackTrace -split [System.Environment]::NewLine
    $stack = $stack -join ([System.Environment]::NewLine + '        ')
    $stack = [System.Environment]::NewLine + '        ' + $stack

    $functionName = Get-PSCallStack | Select-Object -Skip 1 -First 1 -ExpandProperty 'Command'
    $msg = $errorMessage -f $PS_MODULE_NAME,
                            $functionName,
                            $ErrorObject.InvocationInfo.ScriptLineNumber,
                            $ErrorObject.Exception.Message,
                            $($statement.ToString().Trim()),
                            $stack,
                            $PSVersionTable.PSVersion.ToString(),
                            $PSVersionTable.PSEdition,
                            $PSVersionTable.Platform

    Write-Host $msg -ForegroundColor Red

}
