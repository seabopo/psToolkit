function Add-StatusMessageTimeStamps {
    <#
    .DESCRIPTION
        Adds a timestamp prefix to the status message.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    process {

        if ( $MessageObject.TimeStamps ) {

            $MessageObject.Message = $( '{0} {1}' -f $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')),
                                                     $MessageObject.Message )

        }

        Write-Output $MessageObject

    }
}
