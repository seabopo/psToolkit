Function Test-Parameters {
    <#
    .DESCRIPTION
        Performs tests based on the values defined in the PipelineObject's Tests parameter. The Test paramater
        is a hashtable that supports the following values/tests:
         - AnyIsNull
         - AllAreNull
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    begin {
        $validTestNames = @('AnyIsNull','AllAreNull')
    }

    process {

        try {

            $invocation = $PipelineObject.Invocation[$PipelineObject.Invocation.ID]

            if ( $invocation.CallStack[0].InvocationInfo.BoundParameters.ContainsKey('Tests') ) {

                $invocation.ParameterTests.Defined = $true

                $tests = $invocation.CallStack[0].InvocationInfo.BoundParameters['Tests']

                $tests.keys | ForEach-Object {

                    $testName = $_

                    if ( $validTestNames -contains $testName ) {

                        $params        = @{}
                        $missingParams = @()

                        $tests[$testName] | ForEach-Object {
                            $paramName = $_
                            if ( $PipelineObject.ContainsKey($paramName) ) {
                                $params.Add($paramName,$PipelineObject[$paramName])
                            }
                            else { $missingParams += $paramName }
                        }

                        if ( $params.count -eq $tests[$testName].count ) {
                            $validationFailed, $failedValues = Test-IsNull -n $testName -v $params -r
                            if ( $validationFailed ) {
                                $invocation.ParameterTests.Successful = $false
                                $invocation.ParameterTests.Errors += $(
                                    '{0} test failed becasue the these values are null: ' -f
                                    $testName, $($failedValues -Join ','))
                            }
                        }
                        else {
                            $invocation.ParameterTests.Successful = $false
                            $invocation.ParameterTests.Errors += $(
                                '{0} test failed. PipelineObject is missing the following Parameter value(s): {1}' -f
                                $testName, $($missingParams -Join ','))
                        }

                    }
                    else {
                        $invocation.ParameterTests.Successful = $false
                        $invocation.ParameterTests.Errors += $(
                            'Tests failed. The following validation test name is not valid: {1}' -f $testName )
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
