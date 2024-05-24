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

    Import-Module '../psToolkit' -Force

    $env:PS_STATUSMESSAGE_LABELS     = $false
    $env:PS_STATUSMESSAGE_TIMESTAMPS = $false


#==================================================================================================================
# Run Status Message Tests
#==================================================================================================================

    Write-StatusMessage -Type 'Header' -Message " Status Message Examples" -DoubleBanner -DoubleSpace -ColorBanners


    Write-StatusMessage -Type 'Process' -Message " Full Paramater Names Tests" -Banner -DoubleSpace -PreSpace

    Write-StatusMessage -Type 'Header'      -Message 'Header Message ...'      -Labels -TimeStamps
    Write-StatusMessage -Type 'Process'     -Message 'Process Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Type 'Success'     -Message 'Success Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Type 'Warning'     -Message 'Warning Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Type 'Failure'     -Message 'Failure Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Type 'Error'       -Message 'Error Message ...'       -Labels -TimeStamps
    Write-StatusMessage -Type 'Exception'   -Message 'Exception Message ...'   -Labels -TimeStamps
    Write-StatusMessage -Type 'Information' -Message 'Information Message ...' -Labels -TimeStamps


    Write-StatusMessage -t 'Process' -m " Alias Paramater Names Tests" -b -ds -ps

    Write-StatusMessage -t 'Header'      -m 'Header Message ...'      -l -ts
    Write-StatusMessage -t 'Process'     -m 'Process Message ...'     -l -ts
    Write-StatusMessage -t 'Success'     -m 'Success Message ...'     -l -ts
    Write-StatusMessage -t 'Warning'     -m 'Warning Message ...'     -l -ts
    Write-StatusMessage -t 'Failure'     -m 'Failure Message ...'     -l -ts
    Write-StatusMessage -t 'Error'       -m 'Error Message ...'       -l -ts
    Write-StatusMessage -t 'Exception'   -m 'Exception Message ...'   -l -ts
    Write-StatusMessage -t 'Information' -m 'Information Message ...' -l -ts


    Write-StatusMessage -Type 'Process' -Message " Full Switch Paramater Names Tests" -Banner -DoubleSpace -PreSpace

    Write-StatusMessage -Header      -Message 'Header Message ...'      -Labels -TimeStamps
    Write-StatusMessage -Process     -Message 'Process Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Success     -Message 'Success Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Warning     -Message 'Warning Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Failure     -Message 'Failure Message ...'     -Labels -TimeStamps
    Write-StatusMessage -Err         -Message 'Error Message ...'       -Labels -TimeStamps
    Write-StatusMessage -Exception   -Message 'Exception Message ...'   -Labels -TimeStamps
    Write-StatusMessage -Information -Message 'Information Message ...' -Labels -TimeStamps


    Write-StatusMessage -p -m " Alias Switch Paramater Names Tests" -b -ds -ps

    Write-StatusMessage -h -m 'Header Message ...'      -l -ts
    Write-StatusMessage -p -m 'Process Message ...'     -l -ts
    Write-StatusMessage -s -m 'Success Message ...'     -l -ts
    Write-StatusMessage -w -m 'Warning Message ...'     -l -ts
    Write-StatusMessage -f -m 'Failure Message ...'     -l -ts
    Write-StatusMessage -e -m 'Error Message ...'       -l -ts
    Write-StatusMessage -x -m 'Exception Message ...'   -l -ts
    Write-StatusMessage -i -m 'Information Message ...' -l -ts


    Write-StatusMessage -p -m " Test Indentation Levels with full names and labels" -b -ds -ps

    Write-StatusMessage -Type 'Information' -Message 'Level 0 ...' -Labels -TimeStamps -IndentationLevel 0
    Write-StatusMessage -Type 'Information' -Message 'Level 1 ...' -Labels -TimeStamps -IndentationLevel 1
    Write-StatusMessage -Type 'Information' -Message 'Level 2 ...' -Labels -TimeStamps -IndentationLevel 2
    Write-StatusMessage -Type 'Information' -Message 'Level 3 ...' -Labels -TimeStamps -IndentationLevel 3
    Write-StatusMessage -Type 'Information' -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4
    Write-StatusMessage -Type 'Success'     -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4
    Write-StatusMessage -Type 'Warning'     -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4
    Write-StatusMessage -Type 'Error'       -Message 'Level 4 ...' -Labels -TimeStamps -IndentationLevel 4


    Write-StatusMessage -p -m " Test Indentation Levels with alias switches and no labels" -b -ds -ps

    Write-StatusMessage -i -m 'Level 0 ...' -ts -il 0
    Write-StatusMessage -i -m 'Level 1 ...' -ts -il 1
    Write-StatusMessage -i -m 'Level 2 ...' -ts -il 2
    Write-StatusMessage -i -m 'Level 3 ...' -ts -il 3
    Write-StatusMessage -i -m 'Level 4 ...' -ts -il 4
    Write-StatusMessage -s -m 'Level 4 ...' -ts -il 4
    Write-StatusMessage -w -m 'Level 4 ...' -ts -il 4
    Write-StatusMessage -e -m 'Level 4 ...' -ts -il 4

    Write-StatusMessage -p -m " Test Environment Variables DISABLED" -b -ds -ps

    $env:PS_STATUSMESSAGE_LABELS     = $false
    $env:PS_STATUSMESSAGE_TIMESTAMPS = $false

    Write-StatusMessage -h -m 'Header Message ...'
    Write-StatusMessage -p -m 'Process Message ...'
    Write-StatusMessage -s -m 'Success Message ...'
    Write-StatusMessage -w -m 'Warning Message ...'
    Write-StatusMessage -f -m 'Failure Message ...'
    Write-StatusMessage -e -m 'Error Message ...'
    Write-StatusMessage -x -m 'Exception Message ...'
    Write-StatusMessage -i -m 'Information Message ...'


    Write-StatusMessage -p -m " Test Environment Variables ENABLED" -b -ds -ps

    $env:PS_STATUSMESSAGE_LABELS     = $true
    $env:PS_STATUSMESSAGE_TIMESTAMPS = $true

    Write-StatusMessage -h -m 'Header Message ...'
    Write-StatusMessage -p -m 'Process Message ...'
    Write-StatusMessage -s -m 'Success Message ...'
    Write-StatusMessage -w -m 'Warning Message ...'
    Write-StatusMessage -f -m 'Failure Message ...'
    Write-StatusMessage -e -m 'Error Message ...'
    Write-StatusMessage -x -m 'Exception Message ...'
    Write-StatusMessage -i -m 'Information Message ...'

    $env:PS_STATUSMESSAGE_LABELS     = $false
    $env:PS_STATUSMESSAGE_TIMESTAMPS = $false

#==================================================================================================================
# Run Exeption Error Tests
#==================================================================================================================

    Write-Msg -h -m " Auto-Generated Error Message Examples" -bb -ds -ps -cb

    try {
        write-host ('test:{0}{3}' -f 'red','green')
    }
    catch {
        Write-Msg -x -m "custom error message`r`n" -o $_
    }

#==================================================================================================================
# Run Debug Object Tests
#==================================================================================================================

    [String]    $testString = "Test String"
    [Int]       $testInt    = 123
    [Bool]      $testBool   = $true
    [String[]]  $testArray  = @("Test Array Item 1", "Test Array Item 2", "Test Array Item 3")

    [Object]    $testObject = New-Object -TypeName PSObject -Property @{
                                  PropertyName1 = "Property Value 1"
                                  PropertyName2 = "Property Value 2"
                              }

    [HashTable] $testHashTable = @{
                                    PropertyName1 = "Property Value 1"
                                    PropertyName2 = "Property Value 2"
                                  }

    $complexObject = @{

        Movies = @(
            @{
                Title = 'Movie 1'
                Year = 2021
                Genres = @('Action','Adventure','Sci-Fi')
                Actors = @(
                    @{ Actor = 'Actor 1'; Role = 'Role 1' }
                    @{ Actor = 'Actor 2'; Role = 'Role 2' }
                )
            },
            @{
                Title = 'Movie 2'
                Year = 2021
                Genres = @('Action','Adventure','Fantasy')
                Actors = @(
                    @{ Actor = 'Actor 1'; Role = 'Role 1' }
                    @{ Actor = 'Actor 2'; Role = 'Role 2' }
                    @{ Actor = 'Actor 3'; Role = 'Role 3' }
                )
            },
            @{
                Title = 'Movie 1'
                Year = 2021
                Genres = @('Action','Adventure','Western')
                Actors = @(
                    @{ Actor = 'Actor 1'; Role = 'Role 1' }
                    @{ Actor = 'Actor 2'; Role = 'Role 2' }
                    @{ Actor = 'Actor 3'; Role = 'Role 3' }
                    @{ Actor = 'Actor 4'; Role = 'Role 4' }
                )
            }
        )
        TelevisionShows = @(
            @{
                Title = 'Show 1'
                Year = 2021
                Genres = @('Action','Adventure','Sci-Fi')
                Actors = @(
                    @{ Actor = 'Actor 1'; Role = 'Role 1' }
                    @{ Actor = 'Actor 2'; Role = 'Role 2' }
                )
                Seasons = @(
                    @{
                        Season = 1
                        Episodes = @(
                            @{ Episode = 1; Title = 'Episode 1'; Description = 'Episode 1 Description' }
                            @{ Episode = 2; Title = 'Episode 2'; Description = 'Episode 2 Description' }
                        )
                    },
                    @{
                        Season = 2
                        Episodes = @(
                            @{ Episode = 1; Title = 'Episode 1'; Description = 'Episode 1 Description' }
                            @{ Episode = 2; Title = 'Episode 2'; Description = 'Episode 2 Description' }
                        )
                    }
                )
            },
            @{
                Title = 'Show 2'
                Year = 2021
                Genres = @('Action','Adventure','Fantasy')
                Actors = @(
                    @{ Actor = 'Actor 1'; Role = 'Role 1' }
                    @{ Actor = 'Actor 2'; Role = 'Role 2' }
                    @{ Actor = 'Actor 3'; Role = 'Role 3' }
                )
                Seasons = @(
                    @{
                        Season = 1
                        Episodes = @(
                            @{ Episode = 1; Title = 'Episode 1'; Description = 'Episode 1 Description' }
                            @{ Episode = 2; Title = 'Episode 2'; Description = 'Episode 2 Description' }
                        )
                    },
                    @{
                        Season = 2
                        Episodes = @(
                            @{ Episode = 1; Title = 'Episode 1'; Description = 'Episode 1 Description' }
                            @{ Episode = 2; Title = 'Episode 2'; Description = 'Episode 2 Description' }
                        )
                    }
                )
            }
        )
    }


    Write-Msg -h -m " Debug Object Examples" -bb -ds  -ps -cb

    Write-Msg -i -ds -m 'Debug Object: ' -o $testString
    Write-Msg -i -ds -m 'Debug Object: ' -o $testInt
    Write-Msg -i -ds -m 'Debug Object: ' -o $testBool
    Write-Msg -i -ds -m 'Debug Object: ' -o $testArray
    Write-Msg -i -ds -m 'Debug Object: ' -o $testObject
    Write-Msg -i -ds -m 'Debug Object: ' -o $testHashTable
    Write-Msg -i -ds -m 'Debug Object: ' -o $complexObject -MaxRecursionDepth 5

    Write-Msg -i -il 3 -ds -m 'Debug Object: ' -o $complexObject -MaxRecursionDepth 30
