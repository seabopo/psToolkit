function Add-StatusMessageBanners {
    <#
    .DESCRIPTION
        Adds a single or double banner to a status message.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    begin {

        $newLine = $( if ( $IsWindows ) { "`r`n" } else { "`n" } )

        $singleBannerLine = '-' * 80

        $doubleBannerLine = '=' * 80

    }


    process {

        if ( $MessageObject.DoubleBanner ) {
            $MessageObject.Message = $doubleBannerLine + $newLine +
                                     $doubleBannerLine + $newLine +
                                     $MessageObject.Message + $newLine +
                                     $doubleBannerLine + $newLine +
                                     $doubleBannerLine
        }
        elseif ( $MessageObject.Banner) {
            $MessageObject.Message = $singleBannerLine + $newLine +
                                     $MessageObject.Message + $newLine +
                                     $singleBannerLine
        }

        Write-Output $MessageObject

    }
}
