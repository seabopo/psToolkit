Function Exit-Processing {
    <#
    .DESCRIPTION
        Checks for PipelineObject initialization erros throws an exception if any are found.
    #>
    [OutputType([Hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

          # Setup the error message template.
            $errorMessage = $( 'Error:'                       ) + [System.Environment]::NewLine +
                            $('    Module: {0}'               ) + [System.Environment]::NewLine +
                            $('    Function: {1}, line: {2}'  ) + [System.Environment]::NewLine +
                            $('    Error Message: {3}'        ) + [System.Environment]::NewLine +
                            $('    Code Statement: {4}'       ) + [System.Environment]::NewLine +
                            $('    Source: {5}'               ) + [System.Environment]::NewLine +
                            $('    PowerShell: {6} {7} on {8}')

          # Get the current invocation object.
            $i = $PipelineObject._Invocation[$PipelineObject._Invocation.ID]

          # Check parameter testing errors.
            if ( $i.Tests.Successful ) {
                Write-Output $PipelineObject
            }
            else {
                $PipelineObject.ResultMessage = $errorMessage -f  $i.ModuleName,
                                                                  $i.CallName,
                                                                  $i.EntryPointLineNumber,
                                                                  $( 'PipelineObject Initialization Error: {0}' -f
                                                                      ($i.Tests.Errors -join ". ") ),
                                                                  $i.EntryPointStatement,
                                                                  $i.EntryPointPosition,
                                                                  $PSVersionTable.PSVersion.ToString(),
                                                                  $PSVersionTable.PSEdition,
                                                                  $PSVersionTable.Platform
                Throw 'psToolkit: PipelineObject" Initialization Error.'
            }
        }

        catch {
            $PipelineObject.Success = $false
            Write-Msg -e -m $PipelineObject.ResultMessage
        }

    }
}
