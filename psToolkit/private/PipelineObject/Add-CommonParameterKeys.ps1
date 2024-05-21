Function Add-CommonParameterKeys {
    <#
    .DESCRIPTION
        Adds keys for the 'CommonParameters' in the callstack's invocation to the PipelineObject. Common
        Parameters are the parameters that are available to all cmdlets and advanced functions by enabling
        the 'CmdletBinding' attribute. They include: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction,
        WarningVariable, OutBuffer, OutVariable, PipelineVariable, and InformationAction.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

            $invocation = $PipelineObject.Invocation[$PipelineObject.Invocation.ID]

            if ( $invocation.IncludeCommonParameters ) {
                $functionDefinition = Get-Command $invocation.Command
                $functionDefinition.Parameters.Keys |
                    ForEach-Object {
                        if ( -not $PipelineObject.ContainsKey($_) ) { $PipelineObject.Add( $_,$null ) }
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
