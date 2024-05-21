Function Add-DefinedParameterKeys {
    <#
    .DESCRIPTION
        Adds keys for the 'DefinedParameters' in the callstack's invocation to the PipelineObject. Defined
        Parameters are the parameters that are explicitly defined in the function's parameter block.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

            $invocation = $PipelineObject.Invocation[$PipelineObject.Invocation.ID]

            if ( $invocation.DefinedParameters ) {
                $invocation.DefinedParameters.GetEnumerator() |
                    ForEach-Object {
                        $key = $_.Name.VariablePath.UserPath.ToString()
                        if ( -not $PipelineObject.ContainsKey($key) ) { $PipelineObject.Add( $key,$null ) }
                    }
            }

            return $PipelineObject

        }
        catch {

            $exceptionMessage = $PS_EXCEPTION_MSG -f $_.Exception.Message,
                                                     $MyInvocation.InvocationName,
                                                     $_.InvocationInfo.ScriptLineNumber,
                                                     $_.ScriptStackTrace

            Write-Msg -x -m $exceptionMessage -TS

        }

    }
}
