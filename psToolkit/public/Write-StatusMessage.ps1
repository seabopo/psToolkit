function Write-StatusMessage {
    <#
    .SYNOPSIS
        Writes a formatted status message to the console.

    .DESCRIPTION
        Writes a formatted status message to the console.

    .PARAMETER Message
        REQUIRED. String. Alias: -m. The message to be written to the console.

    .PARAMETER Type
        OPTIONAL. String. Alias: -t. The type of message to write. The type determines the color and the label.
        Default value: 'Information'.
                  Valid Types:
                    - Header      :: Color = Magenta
                    - Process     :: Color = Cyan
                    - Information :: Color = Gray
                    - Success     :: Color = Green
                    - Failure     :: Color = Red
                    - Error       :: Color = Red
                    - Warning     :: Color = Yellow
                    - Exception   :: Color = Red (also writes the last exception error message)

        The type of message can also be set using the following switches:
            -Header, -Process, -Info, -Success, -Warning, -Failure, -Err -ExceptionError

    .PARAMETER Header
        OPTIONAL. Switch. Alias: -h. Switch alternative for the Header Type paramater. Message Color: Magenta.

    .PARAMETER Process
        OPTIONAL. Switch. Alias: -p. Switch alternative for the Process Type paramater. Message Color: Cyan.

    .PARAMETER Information
        OPTIONAL. Switch. Alias: -i. Switch alternative for the Information Type paramater. Message Color: Gray.

    .PARAMETER Success
        OPTIONAL. Switch. Alias: -s. Switch alternative for the Success Type paramater. Message Color: Green.

    .PARAMETER Warning
        OPTIONAL. Switch. Alias: -w. Switch alternative for the Warning Type paramater. Message Color: Yellow.

    .PARAMETER Failure
        OPTIONAL. Switch. Alias: -f. Switch alternative for the Failure Type paramater. Message Color: Red.

    .PARAMETER Err
        OPTIONAL. Switch. Alias: -e. Switch alternative for the Error Type paramater. Message Color: Red.

    .PARAMETER Exception
        OPTIONAL. Switch. Alias: -x. Switch alternative for the Exception Type paramater. Message Color: Red.
        This switch will also write the last exception error message to the console.

    .PARAMETER TimeStamps
        OPTIONAL. Switch. Alias: -ts. Prefixes each message with a timestamp in the format" 'yyyy-MM-dd HH:mm:ss'.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_TIMESTAMPS = $true

    .PARAMETER Labels
        OPTIONAL. Switch. Alias: -l. Prefixes each message with the message type.
        Labels: SUCCESS, FAILURE, WARNING, ERROR, EXCEPTION.
        Messages with the Header, Process, and Information types will not have labels.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_LABELS = $true

    .PARAMETER IndentationLevel
        OPTIONAL. Integer. Alias: -il. Indents the message using the string specified by the IndentationString
        parameter. This value is a multiplier for the IndentationString, so an IndentationString value of 3
        periods ('...') and an IndentationLevel value of 2 will indent the message by 6 periods ('......').
        Default value: 0.

    .PARAMETER IndentationString
        OPTIONAL. String. Alias: -is. A string of characters used for indentation. Default value: '...'.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_INDENTATION_STRING = '...'

    .PARAMETER Banner
        OPTIONAL. Switch. Alias: -b. Writes a line of characters above and below the message to make it more
        visible. The characters used for the banner are set by the BannerString parameter. The length of the banner
        is determined by the BannerLength parameter.

    .PARAMETER DoubleBanner
        OPTIONAL. Switch. Alias: -bb. Writes two lines of characters above and below the message to make it more
        visible. The characters used for the banner are set by the BannerString parameter. The length of the banner
        is determined by the BannerLength parameter.

    .PARAMETER BannerString
        OPTIONAL. String. Alias: -bs. A string of one or more characters to use as a console banner. This string
        will be repeated to create a banner. Default value: '='.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_BANNER_STRING = '='

    .PARAMETER BannerLength
        OPTIONAL. Integer. Alias: -bl. The length of the banner to write above and below the message. The value of
        the BannerString parameter will be repeated as necessary to create this line length. Extra characters will
        be truncated.  Default value: 80.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_BANNER_LENGTH = 80

    .PARAMETER ColorBanners
        OPTIONAL. Switch. Alias: -cb. Colors the banners to match the message type. Default value: $false.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_COLOR_BANNERS = $true

    .PARAMETER DoubleSpace
        OPTIONAL. Switch. Alias: -ds. Adds a blank line after the logged item.

    .PARAMETER PreSpace
        OPTIONAL. Switch. Alias: -ps. Adds a blank line before the logged item.

    .PARAMETER DebugObject
        OPTIONAL. Alias: -do. A variable whose properties will be written to the console. The object is
        converted to a JSON object for display to the screen. If the object is a simple type (string, int, etc.)
        it will be written directly on the same line as the message. if the object is a complex type, it will be
        written on multiple lines following the message line.

    .PARAMETER MaxRecursionDepth
        OPTIONAL. Integer. Alias: -rd. The maximum depth of recursion when converting the DebugObject to a JSON
        string. Default value: 3. The powreshell maxium value is 100.
        This value can be set using an environment variable.
            Example: $env:PS_STATUSMESSAGE_MAX_RECURSION_DEPTH = 10

    .EXAMPLE
        Write-StatusMessage -Type 'Header' -Message 'Starting Testing ...'

    .EXAMPLE
        Write-Status -Type 'Header' -Message 'Starting Testing ...'

    .EXAMPLE
        Write-Message -i -m 'Testing ...'

    .EXAMPLE
        Write-Msg -i -m 'Testing ...'
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

        [Alias('ts')] [Switch]         $TimeStamps = [System.Convert]::ToBoolean($env:PS_STATUSMESSAGE_TIMESTAMPS),
        [Alias('l')]  [Switch]         $Labels     = [System.Convert]::ToBoolean($env:PS_STATUSMESSAGE_LABELS),

        [Alias('il')] [Int]            $IndentationLevel = 0,
        [Alias('is')] [String]         $IndentationString = $env:PS_STATUSMESSAGE_INDENTATION_STRING,

        [Alias('b')]  [Switch]         $Banner,
        [Alias('bb')] [Switch]         $DoubleBanner,
        [Alias('bs')] [String]         $BannerString = $env:PS_STATUSMESSAGE_BANNER_STRING,
        [Alias('bl')] [Int]            $BannerLength = [System.Convert]::ToInt32($env:PS_STATUSMESSAGE_BANNER_LENGTH),
        [Alias('cb')] [Switch]         $ColorBanners = [System.Convert]::ToBoolean($env:PS_STATUSMESSAGE_COLOR_BANNERS),

        [Alias('ds')] [Switch]         $DoubleSpace,
        [Alias('ps')] [Switch]         $PreSpace,

        [Alias('do')]                  $DebugObject,
        [Alias('rd')] [Int]            $MaxRecursionDepth = 3

    )

    process {

        try {

          # Set the Message Type if it was set by a switch rather than the Type parameter.
            if ( [String]::IsNullOrEmpty($Type) ) {

                $Type = switch ( $PSCmdlet.ParameterSetName )
                        {
                            'isHeader'      { 'Header'      }
                            'isProcess'     { 'Process'     }
                            'isInformation' { 'Information' }
                            'isSuccess'     { 'Success'     }
                            'isWarning'     { 'Warning'     }
                            'isFailure'     { 'Failure'     }
                            'isError'       { 'Error'       }
                            'isException'   { 'Exception'   }
                        }

            }

          # Create a PipelineObject to pass through the rest of the functions. Messages are written a lot so do this
          # manually rather than using the Initialize-PipelineObject function to keep it as performant as possible.
            $messageObject = [Hashtable]@{
                Message            = $Message
                Type               = $Type
                TimeStamps         = $TimeStamps.ToBool()
                Labels             = $Labels.ToBool()
                IndentationLevel   = $IndentationLevel
                IndentationString  = $IndentationString
                Banner             = $Banner.ToBool()
                DoubleBanner       = $DoubleBanner.ToBool()
                BannerString       = $BannerString
                BannerLength       = $BannerLength
                ColorBanners       = $ColorBanners.ToBool()
                DoubleSpace        = $DoubleSpace.ToBool()
                PreSpace           = $PreSpace.ToBool()
                DebugObject        = $DebugObject
                MaxRecursionDepth  = $MaxRecursionDepth
                MessagePrefix      = $null
                MessageBanners     = $null
                DebugObjectPrefix  = $null
            }

          # Pipeline the message object through all of the message formatting functions.
            $messageObject |
                Set-StatusMessageColor |
                Set-StatusMessagePrefix |
                Set-StatusMessageBanners |
                Write-StatusMessageToConsole |
                Out-Null

        }
        catch {

            Write-ExceptionMessage -e $_ -n $MyInvocation.InvocationName

        }

    }
}
