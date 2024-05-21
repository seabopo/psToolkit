function Write-StatusMessage {
    <#
    .SYNOPSIS
        Writes a formatted status message to the console.

    .DESCRIPTION
        Writes a formatted status message to the console.

    .PARAMETER Message
        REQUIRED. String. Alias: -m. The message to be written to the console or log.

    .PARAMETER Type
        OPTIONAL. String. Alias: -t. The type of message to write. The type determines the color and the label.
        Default value: 'Info' (Color = Gray).
                  Valid types:
                    - Header    :: Color = Magenta
                    - Process   :: Color = Cyan
                    - Info      :: Color = Gray
                    - Success   :: Color = Green
                    - Failure   :: Color = Red
                    - Error     :: Color = Red
                    - Warning   :: Color = Yellow
                    - Exception :: Color = Red and writes the last exception error message.

        The type of message can also be set using the following switches:
            -Header, -Process, -Info, -Success, -Warning, -Failure, -Err -ExceptionError

    .PARAMETER Header
        OPTIONAL. Switch. Alias: -h. Switch alternative for the Header Type paramater.

    .PARAMETER Process
        OPTIONAL. Switch. Alias: -p. Switch alternative for the Process Type paramater.

    .PARAMETER Information
        OPTIONAL. Switch. Alias: -i. Switch alternative for the Information Type paramater.

    .PARAMETER Success
        OPTIONAL. Switch. Alias: -s. Switch alternative for the Success Type paramater.

    .PARAMETER Warning
        OPTIONAL. Switch. Alias: -w. Switch alternative for the Warning Type paramater.

    .PARAMETER Failure
        OPTIONAL. Switch. Alias: -f. Switch alternative for the Failure Type paramater.

    .PARAMETER Err
        OPTIONAL. Switch. Alias: -e. Switch alternative for the Error Type paramater.

    .PARAMETER Exception
        OPTIONAL. Switch. Alias: -x. Switch alternative for the Exception error Type paramater.

    .PARAMETER Labels
        OPTIONAL. Switch. Alias: -l. Prefixes each message with the message type.
        Values: SUCCESS, FAILURE, WARNING, ERROR, EXCEPTION.

    .PARAMETER Banner
        OPTIONAL. Switch. Alias: -b. Writes a line of dashes above and below the message to make it more visible.

    .PARAMETER DoubleBanner
        OPTIONAL. Switch. Alias: -bb. Writes two lines of dashes above and below the message to make it more visible.

    .PARAMETER TimeStamps
        OPTIONAL. Switch. Alias: -ts. Writing the timestamp to the message.

    .PARAMETER DoubleSpace
        OPTIONAL. Switch. Alias: -ds. Adds a blank line after the logged item.

    .PARAMETER PreSpace
        OPTIONAL. Switch. Alias: -ps. Adds a blank line before the logged item.

    .PARAMETER IndentationLevel
        OPTIONAL. Integer. Alias: -il. Indents the message by the number of characters specified using the
        IndentationCharacter parameter. Default value: 0.

    .PARAMETER IndentationString
        OPTIONAL. String. Alias: -is. A string of characters used for indentation. Default value: '...'.
        The indentation string will be followed by a space before the message is written.

    .PARAMETER DebugObject
        OPTIONAL. PSCustomObject. Alias: -do. A variable whose properties will be written to the console. The
        function will iterate through the properties/keys.

    .PARAMETER RecurseDebugObject
        OPTIONAL. Switch. Alias: -rdo. Recurses through the DebugObject properties and writes all sub-objects.

    .PARAMETER MaxRecursionDepth
        OPTIONAL. Integer. Alias: -mrd. The maximum depth of recursion when writing the DebugObject properties.
        Default value: 3.

    .EXAMPLE
        Write-StatusMessage -Type 'Header' -Message 'Starting Testing ...'

    .EXAMPLE
        Write-Status -Type 'Header' -Message 'Starting Testing ...'

    .EXAMPLE
        Write-Message -I -M 'Testing ...'

    .EXAMPLE
        Write-Msg -I -M 'Testing ...'
    #>

    [OutputType([void])]
    [CmdletBinding(DefaultParameterSetName = "isInformation")]
    [Alias('Write-Status','Write-Message','Write-Msg')]
    param (

        [Parameter()]
        [AllowEmptyString()][AllowNull()]
        [Alias('m')]  [string]         $Message,

        [Parameter(ParameterSetName = "byTypeName")]
        [ValidateSet('Header','Process','Information','Success','Warning','Failure','Error','Exception')]
        [Alias('t')]  [String]         $Type,

        [Parameter(ParameterSetName = "isHeader")]
        [Alias('h')]  [Switch]         $Header,

        [Parameter(ParameterSetName = "isProcess")]
        [Alias('p')]  [Switch]         $Process,

        [Parameter(ParameterSetName = "isInformation")]
        [Alias('i')]  [Switch]         $Information,

        [Parameter(ParameterSetName = "isSuccess")]
        [Alias('s')]  [Switch]         $Success,

        [Parameter(ParameterSetName = "isWarning")]
        [Alias('w')]  [Switch]         $Warning,

        [Parameter(ParameterSetName = "isFailure")]
        [Alias('f')]  [Switch]         $Failure,

        [Parameter(ParameterSetName = "isError")]
        [Alias('e')]  [Switch]         $Err,

        [Parameter(ParameterSetName = "isException")]
        [Alias('x')]  [Switch]         $Exception,

        [Alias('l')]  [Switch]         $Labels,
        [Alias('b')]  [Switch]         $Banner,
        [Alias('bb')] [Switch]         $DoubleBanner,
        [Alias('ts')] [Switch]         $TimeStamps,
        [Alias('ds')] [Switch]         $DoubleSpace,
        [Alias('ps')] [Switch]         $PreSpace,

        [Alias('il')] [Int]            $IndentationLevel = 0,
        [Alias('is')] [String]         $IndentationString = '...',

        [Alias('do')] [PSCustomObject] $DebugObject,
        [Alias('rd')] [Switch]         $RecurseDebugObject,
        [Alias('md')] [Int]            $MaxRecursionDepth = 1

    )

    process {

        try {

          # Set the Message Type if it was set by a switch rather than the Type parameter.
            if ( [String]::IsNullOrEmpty($Type) ) {

                $Type = switch ( $PSCmdlet.ParameterSetName ) {
                            "isHeader"          { "Header"         }
                            "isProcess"         { "Process"        }
                            "isInformation"     { "Information"    }
                            "isSuccess"         { "Success"        }
                            "isWarning"         { "Warning"        }
                            "isFailure"         { "Failure"        }
                            "isError"           { "Error"          }
                            "isException" { "Exception" }
                        }

            }

          # Create a PipelineObject to pass through the rest of the functions. Messages are written a lot so do this
          # manually rather than using the Initialize-PipelineObject function to keep it as performant as possible.
            $messageObject = [Hashtable]@{
                Message            = $Message
                Type               = $Type
                Labels             = $Labels.ToBool()
                Banner             = $Banner.ToBool()
                DoubleBanner       = $DoubleBanner.ToBool()
                TimeStamps         = $TimeStamps.ToBool()
                DoubleSpace        = $DoubleSpace.ToBool()
                PreSpace           = $PreSpace.ToBool()
                IndentationLevel   = $IndentationLevel
                IndentationString  = $IndentationString
                DebugObject        = $DebugObject
                RecurseDebugObject = $RecurseDebugObject.ToBool()
                MaxRecursionDepth  = $MaxRecursionDepth
            }

          # Pipeline the message object through all of the message formatting functions.
            $messageObject |
                Set-StatusMessageColor |
                Add-StatusMessageIndentation |
                Add-StatusMessageLabels |
                Add-StatusMessageTimeStamps |
                Add-StatusMessageBanners |
                Write-StatusMessageToConsole |
                Out-Null

        }
        catch {
            Write-Host "An error occurred while writing the status message: $_" -ForegroundColor Red
        }

    }
}


# if ( $PSCustomObject ) { $PSCustomObject.GetEnumerator() | Sort-Object Name | Out-File $WS_APP_LOG_PATH -Append }