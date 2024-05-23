Function Test-Parameters {
    <#
    .DESCRIPTION
        Performs tests based on the values defined in the PipelineObject's Tests parameter. The Test paramater
        is a hashtable that supports the following values/tests:
         - AnyIsNull
         - AllAreNull
    #>
    [OutputType([Hashtable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [Hashtable] $PipelineObject )

    begin {
        $validTestNames = @('AnyIsNull','AllAreNull')
    }

    process {

        try {

            $i = $PipelineObject._Invocation[$PipelineObject._Invocation.ID]

            if ( $i.CallStack[0].InvocationInfo.BoundParameters.ContainsKey('Tests') ) {

                $i.ParameterTests.Defined = $true

                $tests = $i.CallStack[0].InvocationInfo.BoundParameters['Tests']

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
                                $i.ParameterTests.Successful = $false
                                $i.ParameterTests.Errors += $(
                                    '{0} test failed becasue the these values are null: ' -f
                                    $testName, $($failedValues -Join ','))
                            }
                        }
                        else {
                            $i.ParameterTests.Successful = $false
                            $i.ParameterTests.Errors += $(
                                '{0} test failed. PipelineObject is missing the following Parameter value(s): {1}' -f
                                $testName, $($missingParams -Join ','))
                        }

                    }
                    else {
                        $i.ParameterTests.Successful = $false
                        $i.ParameterTests.Errors += $(
                            'Tests failed. The following validation test name is not valid: {1}' -f $testName )
                    }

                }

            }

            Write-Output $PipelineObject

        }
        catch {

            Write-ExceptionMessage -e $_ -n $MyInvocation.InvocationName

        }

    }
}
