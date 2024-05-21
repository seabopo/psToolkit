Function Remove-RecursiveObjectKey {
    <#
    .DESCRIPTION
        Checks the calling function for an existing PipelineObject and removes it to prevent recursion and the
        potential memory or performance issues. The PipelineObject can be identified by it's type
        [Hashtable], the 'ValueFromPipeline' attribute and the 'Invocation' key. This function assumes that the
        PipelineObject WILL BE PASSED THOUGH THE PIPELINE ... if it is not, the function will intentionally not
        clean the object so that a user may pass multiple PipelineObjects to the function if required.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

            $invocation = $PipelineObject.Invocation[$PipelineObject.Invocation.ID]

            $invocation.DefinedParameters |
                Where-Object { $_.Extent.ToString() -like '*ValueFromPipeline*Hashtable*' } |
                ForEach-Object {
                    $key = $_.Name.VariablePath.UserPath.ToString()
                    if ( $invocation.BoundParameters.ContainsKey($key) ) {
                        if ( $invocation.BoundParameters[$key].ContainsKey('Invocation') ) {
                            $PipelineObject.Remove($key)
                        }
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
