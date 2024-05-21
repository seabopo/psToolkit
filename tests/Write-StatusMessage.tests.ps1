#==================================================================================================================
#==================================================================================================================
# Tests :: Write-StatusMessage
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

    Clear-Host

    Set-Location  -Path $PSScriptRoot
    Push-Location -Path $PSScriptRoot

    $ErrorActionPreference = "Stop"

    Import-Module $("../{0}" -f (Get-Item $PSScriptRoot).Parent.Name) -Force


#==================================================================================================================
# Run Status Message Tests
#==================================================================================================================

    Write-StatusMessage -Type 'Header' -Message " Status Message Examples" -DoubleBanner -DoubleSpace


    Write-StatusMessage -Type 'Process' -Message " Full Paramater Names Tests" -Banner -DoubleSpace -PreSpace

    Write-StatusMessage -Type 'Header'      -Message 'Header Message ...'      -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Process'     -Message 'Process Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Success'     -Message 'Success Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Warning'     -Message 'Warning Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Failure'     -Message 'Failure Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Error'       -Message 'Error Message ...'       -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Exception'   -Message 'Exception Message ...'   -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Type 'Information' -Message 'Information Message ...' -Labels -TimeStamps -DoubleSpace


    Write-StatusMessage -t 'Process' -m " Alias Paramater Names Tests" -b -ds -ps

    Write-StatusMessage -t 'Header'      -m 'Header Message ...'      -l -ts -ds
    Write-StatusMessage -t 'Process'     -m 'Process Message ...'     -l -ts -ds
    Write-StatusMessage -t 'Success'     -m 'Success Message ...'     -l -ts -ds
    Write-StatusMessage -t 'Warning'     -m 'Warning Message ...'     -l -ts -ds
    Write-StatusMessage -t 'Failure'     -m 'Failure Message ...'     -l -ts -ds
    Write-StatusMessage -t 'Error'       -m 'Error Message ...'       -l -ts -ds
    Write-StatusMessage -t 'Exception'   -m 'Exception Message ...'   -l -ts -ds
    Write-StatusMessage -t 'Information' -m 'Information Message ...' -l -ts -ds


    Write-StatusMessage -Type 'Process' -Message " Full Switch Paramater Names Tests" -Banner -DoubleSpace -PreSpace

    Write-StatusMessage -Header      -Message 'Header Message ...'      -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Process     -Message 'Process Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Success     -Message 'Success Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Warning     -Message 'Warning Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Failure     -Message 'Failure Message ...'     -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Err         -Message 'Error Message ...'       -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Exception   -Message 'Exception Message ...'   -Labels -TimeStamps -DoubleSpace
    Write-StatusMessage -Information -Message 'Information Message ...' -Labels -TimeStamps -DoubleSpace


    Write-StatusMessage -p -m " Alias Switch Paramater Names Tests" -b -ds -ps

    Write-StatusMessage -h -m 'Header Message ...'      -l -ts -ds
    Write-StatusMessage -p -m 'Process Message ...'     -l -ts -ds
    Write-StatusMessage -s -m 'Success Message ...'     -l -ts -ds
    Write-StatusMessage -w -m 'Warning Message ...'     -l -ts -ds
    Write-StatusMessage -f -m 'Failure Message ...'     -l -ts -ds
    Write-StatusMessage -e -m 'Error Message ...'       -l -ts -ds
    Write-StatusMessage -x -m 'Exception Message ...'   -l -ts -ds
    Write-StatusMessage -i -m 'Information Message ...' -l -ts -ds


    Write-StatusMessage -p -m " Test Indentation Levels with full names and labels" -b -ds -ps

    Write-StatusMessage -Type 'Information' -Message 'Level 0 ...' -Labels -TimeStamps -IndentationLevel 0
    Write-StatusMessage -Type 'Information' -Message 'Level 1 ...' -Labels -TimeStamps -IndentationLevel 1
    Write-StatusMessage -Type 'Information' -Message 'Level 2 ...' -Labels -TimeStamps -IndentationLevel 2
    Write-StatusMessage -Type 'Information' -Message 'Level 3 ...' -Labels -TimeStamps -IndentationLevel 3
    Write-StatusMessage -Type 'Information' -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4
    Write-StatusMessage -Type 'Success'     -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4
    Write-StatusMessage -Type 'Warning'     -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4
    Write-StatusMessage -Type 'Error'       -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4


    Write-StatusMessage -p -m " Test Indentation Levels with alias switches" -b -ds -ps

    Write-StatusMessage -i -m 'Level 0 ...' -ts -il 0
    Write-StatusMessage -i -m 'Level 1 ...' -ts -il 1
    Write-StatusMessage -i -m 'Level 2 ...' -ts -il 2
    Write-StatusMessage -i -m 'Level 3 ...' -ts -il 3
    Write-StatusMessage -i -m 'Level 4 ...' -ts -il 4
    Write-StatusMessage -s -m 'Level 4 ...' -ts -il 4
    Write-StatusMessage -w -m 'Level 4 ...' -ts -il 4
    Write-StatusMessage -e -m 'Level 4 ...' -ts -il 4


#==================================================================================================================
# Run Debug Object Tests
#==================================================================================================================

    [String] $testString = "Test String"
    [Int]    $testInt    = 123
    [Bool]   $testBool   = $true
    [Array]  $testArray  = @("Test Array Item 1", "Test Array Item 2", "Test Array Item 3")
    [Object] $testObject = New-Object -TypeName PSObject -Property @{
                               Name  = "Test Object Name"
                               Value = "Test Object Value"
                           }
    [HashTable] $testHashTable = @{
                                      Name  = "Test HashTable"
                                      Value = "Test Value"
                                  }

    Write-StatusMessage -Type 'Header' -Message " Debug Object Examples" -DoubleBanner -DoubleSpace


    Write-StatusMessage -Type 'Process' -Message " Full Paramater Names Tests" -Banner -DoubleSpace -PreSpace

    Write-StatusMessage -Information -Message 'Debug Object ...' -DebugObject $testString
    Write-StatusMessage -Information -Message 'Debug Object ...' -DebugObject $testInt
    Write-StatusMessage -Information -Message 'Debug Object ...' -DebugObject $testBool
    Write-StatusMessage -Information -Message 'Debug Object ...' -DebugObject $testArray
    Write-StatusMessage -Information -Message 'Debug Object ...' -DebugObject $testObject
    Write-StatusMessage -Information -Message 'Debug Object ...' -DebugObject $testHashTable

