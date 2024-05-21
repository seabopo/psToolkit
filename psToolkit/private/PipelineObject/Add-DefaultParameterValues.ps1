Function Add-DefaultParameterValues {
    <#
    .DESCRIPTION
        Adds the default values of the 'BoundParameters' collection in the callstack's invocation to the
        PipelineObject. Default values will only override existing null values or empty strings.
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
                        $name         = $_.Name.VariablePath.UserPath.ToString()
                        $defaultValue = $_.DefaultValue
                        if ( [string]::IsNullOrEmpty($PipelineObject[$name]) ) {
                            if ( -not [string]::IsNullOrEmpty($defaultValue) ) {
                                $PipelineObject[$name] = $(Invoke-Expression $($defaultValue.Extent.Text))
                            }
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
