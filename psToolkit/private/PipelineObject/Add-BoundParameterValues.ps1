Function Add-BoundParameterValues {
    <#
    .DESCRIPTION
        Adds the values for the 'BoundParameters' collection in the callstack's invocation to the PipelineObject.
        BoundParameters are the parameters that were passed to the function when it was called. BoundParameters
        will override any previously existing values in the PipelineObject.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

            $invocation = $PipelineObject.Invocation[$PipelineObject.Invocation.ID]

            $invocation.BoundParameters.GetEnumerator() |
                ForEach-Object {
                    if ( $PipelineObject.ContainsKey($_.key) ) { $PipelineObject[$_.key] = $_.value }
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
