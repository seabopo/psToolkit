Function Add-InvocationData {
    <#
    .DESCRIPTION
        Adds the invocation data of the function which called the entrypoint (Initialize-PipelineObject) function.
        The Invocation hashtable is a callstack of each entrypoint call for the PipelineObject so that the data
        can be used for error reporting.
    #>
    [OutputType([Hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    process {

        try {

          # If the 'Invocation' key does not exist, create it and it's ID sub-key.
            if ( -not $PipelineObject.ContainsKey('_Invocation') ) {
                $PipelineObject.Add('_Invocation',@{})
                $PipelineObject._Invocation.Add('ID',$null)
            }

          # Get the callstack for the entrypoint, the entrypoint caller and the caller's predecessor.
            $callStack = Get-PSCallStack | Select-Object -Skip 1 -First 3

          # Get the entrypoint (Initialize-PipelineObject) parameters.
            $entryPointParams = $callStack[0].InvocationInfo.BoundParameters

          # Get the caller's invocation information.
            $InvocationInfo = $callStack[1].InvocationInfo

          # Build the invocation object.
            $Invocation = @{

                ID                          = '{0}::{1}::{2}' -f $InvocationInfo.InvocationName,
                                                                 $predecessorInvokedFrom,
                                                                 [Guid]::NewGuid()
                CallName                    = $InvocationInfo.InvocationName
                CommandName                 = $InvocationInfo.MyCommand.Name
                Time                        = $((Get-Date).ToString('yyyy-MM-dd:HH-mm-ss-fff'))
                InvokedFromPath             = if ( $callStack[2] ) { $callStack[2].ToString() } else { '' }
                InvokedFromName             = if ( $callStack[2] ) { $callStack[2].Location   } else { '' }

                CallStack                   = $callStack
                Command                     = $InvocationInfo.MyCommand
                AllParameters               = $InvocationInfo.MyCommand.Parameters
                BoundParameters             = $InvocationInfo.BoundParameters
                DefinedParameters           = $InvocationInfo.MyCommand.ScriptBlock.Ast.Body.ParamBlock.Parameters

                PipelineObjectParameterName = $null

                ParameterTests              = @{ Defined = $false; Successful = $true; Errors = @() }

                PowerShellVersion           = $PSVersionTable.PSVersion
                PowerShellEdition           = $PSVersionTable.PSEdition
                PowerShellPlatform          = $PSVersionTable.Platform
                PowerShellOS                = $PSVersionTable.OS
                Account                     = $([Security.Principal.WindowsIdentity]::GetCurrent().Name)
                Device                      = $env:COMPUTERNAME
                IPAddresses                 = Get-NetIPAddress | ForEach-Object {
                                                  @{ $_.InterfaceAlias = $_.IPAddress }
                                               }

                LogInvocation               = $($entryPointParams.keys -contains 'LogInvocation')
                DontLogParameters           = $($entryPointParams.keys -contains 'DontLogParameters')
                LogPipelineObjectValues     = $($entryPointParams.keys -contains 'LogPipelineObjectValues')
                IncludeCommonParameters     = $($entryPointParams.keys -contains 'IncludeCommonParameters')
                IgnoreParameterNames        = $IgnoreParameterNames

            }

          # Add the invocation object to the PipelineObject's Invocation collection.
            $PipelineObject._Invocation.Add($Invocation.ID,$Invocation)

          # Set the PipelineObject's Invocation ID to the current Invocation ID. This is used by the remaining
          # pipeline functions to add their data and it allows the user to referece the Invocation object in code
          # for error reporting or debugging.
            $PipelineObject._Invocation.ID = $Invocation.ID

          # Write the updated object to the pipeline.
            Write-Output $PipelineObject

        }
        catch {

          Write-ExceptionMessage -e $_ -n $MyInvocation.InvocationName

      }

    }
}
