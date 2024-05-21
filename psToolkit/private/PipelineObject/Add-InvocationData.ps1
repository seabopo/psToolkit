Function Add-InvocationData {
    <#
    .DESCRIPTION
        Adds the invocation data of the function which called the entrypoint (Initialize-PipelineObject) function.
        The Invocation hashtable is a callstack of each entrypoint call for the PipelineObject so that the data
        can be used for error reporting.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

          # If the 'Invocation' key does not exist, create it and it's ID sub-key.
            if ( -not $PipelineObject.ContainsKey('Invocation') ) {
                $PipelineObject.Add('Invocation',@{})
                $PipelineObject.Invocation.Add('ID',$null)
            }

          # Get the callstack for the entrypoint, the entrypoint caller and the caller's predecessor.
            $callStack = Get-PSCallStack | Select-Object -Skip 1 -First 3

          # Get the entrypoint (Initialize-PipelineObject) parameters.
            $entryPointParams = $callStack[0].InvocationInfo.BoundParameters

          # Get the caller's invocation information.
            $InvocationInfo = $callStack[1].InvocationInfo

          # Get the predecessor's information - if it exists.
            $predecessorSource      = if ( $callStack[2] ) { $callStack[2].ToString() } else { '' }
            $predecessorInvokedFrom = if ( $callStack[2] ) { $callStack[2].Location   } else { '' }

          # Build the invocation object.
            $Invocation = @{
                ID                        = '{0}::{1}::{2}' -f $InvocationInfo.InvocationName,
                                                               $predecessorInvokedFrom,
                                                               [Guid]::NewGuid()
                LocalTime                 = Get-Date
                PowerShellVersion         = $PSVersionTable.PSVersion
                PowerShellEdition         = $PSVersionTable.PSEdition
                PowerShellPlatform        = $PSVersionTable.Platform
                PowerShellOS              = $PSVersionTable.OS
                Account                   = $([Security.Principal.WindowsIdentity]::GetCurrent().Name)
                Device                    = $env:COMPUTERNAME
                IPAddress                 = $(Get-NetIPAddress)
                Source                    = $predecessorSource
                InvokedFrom               = $predecessorInvokedFrom
                Name                      = $InvocationInfo.InvocationName
                Command                   = $InvocationInfo.MyCommand
                BoundParameters           = $InvocationInfo.BoundParameters
                DefinedParameters         = $InvocationInfo.MyCommand.ScriptBlock.Ast.Body.ParamBlock.Parameters
                AllParameters             = $InvocationInfo.MyCommand.Parameters
                CallStack                 = $callStack
                EnableLogging             = $($entryPointParams.keys -contains 'EnableLogging')
                NoLogFunctionCalls        = $($entryPointParams.keys -contains 'NoLogFunctionCalls')
                NoLogParameters           = $($entryPointParams.keys -contains 'NoLogParameters')
                NoLogPipelineObjectValues = $($entryPointParams.keys -contains 'NoLogPipelineObjectValues')
                IncludeCommonParameters   = $($entryPointParams.keys -contains 'IncludeCommonParameters')
                ParameterTests            = @{ Defined = $false; Successful = $true; Errors = @() }
            }

          # Add the invocation object to the PipelineObject's Invocation collection.
            $PipelineObject.Invocation.Add($Invocation.ID,$Invocation)

          # Set the PipelineObject's Invocation ID to the current Invocation ID. This is used by the remaining
          # pipeline functions to add their data and it allows the user to referece the Invocation object in code
          # for error reporting or debugging.
            $PipelineObject.Invocation.ID = $Invocation.ID

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
