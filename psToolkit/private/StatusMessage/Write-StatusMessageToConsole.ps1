function Write-StatusMessageToConsole {
    <#
    .DESCRIPTION
        Writes a formatted status message to the console.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    process {

        if ( $MessageObject.PreSpace ) { Write-Host '' }

        Write-Host $MessageObject.Message -ForegroundColor $MessageObject.MessageColor

        if ( $MessageObject.DoubleSpace ) { Write-Host '' }

    }
}
