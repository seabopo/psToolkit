function Write-StatusMessageToConsole {
    <#
    .DESCRIPTION
        Writes a formatted status message to the console.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    begin {

        $bannerColor = @{ ForegroundColor = 'White' }

    }

    process {

        try {

            if ( $MessageObject.ColorBanners ) { $bannerColor = @{ForegroundColor=$MessageObject.MessageColor} }

            if ( $MessageObject.PreSpace ) { Write-Host '' }

            if ( $MessageObject.MessageBanners ) { Write-Host $MessageObject.MessageBanners @bannerColor }

            if ( $null -eq $MessageObject.MessageObject ) {

                $MessageObject.Message = $MessageObject.MessagePrefix + $MessageObject.Message
                Write-Host $MessageObject.Message -ForegroundColor $MessageObject.MessageColor

            }
            else {

                $convertParams = @{
                    Object          = $MessageObject.MessageObject
                    MaxDepth        = $MessageObject.MaxRecursionDepth
                    MultiLinePrefix = $MessageObject.MessageObjectPrefix
                }
                $value, $multiLine = ConvertTo-MessageString @convertParams -r

                if ( $multiLine ) {
                    $MessageObject.Message = $MessageObject.MessagePrefix + $MessageObject.Message +
                                             '[' + $MessageObject.MessageObject.GetType().Name + ']' +
                                             $value
                    Write-Host $MessageObject.Message -ForegroundColor $MessageObject.MessageColor
                }
                else {
                    $MessageObject.Message = $MessageObject.MessagePrefix + $MessageObject.Message + $value
                    Write-Host $MessageObject.Message -ForegroundColor $MessageObject.MessageColor
                }

            }

            if ( $MessageObject.MessageBanners ) { Write-Host $MessageObject.MessageBanners @bannerColor }

            if ( $MessageObject.DoubleSpace ) { Write-Host '' }

        }
        catch {

            Write-ExceptionMessage -e $_

        }

    }
}
