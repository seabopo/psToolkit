Function Remove-RecursiveObjectKey {
    <#
    .DESCRIPTION
        Checks the calling function for an existing PipelineObject and removes it to prevent recursion. The
        PipelineObject can be identified by it's type [Hashtable], the 'ValueFromPipeline' attribute and the
        'Invocation' key. This function assumes that the PipelineObject WILL BE PASSED THOUGH THE PIPELINE ...
        if it is not, the function will not clean the object. This allows a user may pass multiple
        PipelineObjects to the function if required.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

            $i = $PipelineObject._Invocation[$PipelineObject._Invocation.ID]

            $i.DefinedParameters |
                Where-Object { $_.Extent.ToString() -like '*ValueFromPipeline*Hashtable*' } |
                ForEach-Object {
                    $key = $_.Name.VariablePath.UserPath.ToString()
                    if ( $i.BoundParameters.ContainsKey($key) ) {
                        if ( $i.BoundParameters[$key].ContainsKey('_Invocation') ) {
                            $i.PipelineObjectParameterName = $key
                            $PipelineObject.Remove($key)
                        }
                    }
                }

            Write-Output $PipelineObject

        }
        catch {

            Write-ExceptionMessage -e $_

        }

    }
}
