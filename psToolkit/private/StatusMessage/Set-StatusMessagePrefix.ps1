function Set-StatusMessagePrefix {
    <#
    .DESCRIPTION
        Sets the prefix ( TimeStamp | Lable | Indentation ) that will be added to each status message line.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    begin {

        $labelTypes = @( 'Success', 'Warning', 'Failure', 'Error', 'Exception' )

    }

    process {

        try {

            $prefix = New-Object System.Collections.Generic.List[System.String]

            if ( $MessageObject.TimeStamps ) {
                $prefix.Add( '{0} ' -f $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')) )
            }

            if ( $MessageObject.Labels -and $MessageObject.Type -in $labelTypes ) {
                $prefix.Add( '{0}: ' -f $MessageObject.Type.ToUpper() )
            }

            if ( $MessageObject.IndentationLevel -gt 0 ) {
                $prefix.Add( '{0} ' -f ($MessageObject.IndentationString * $MessageObject.IndentationLevel) )
            }

            $MessageObject.MessagePrefix = $prefix -join ''

            if ( $null -ne $MessageObject.MessagePrefix ) {
                $MessageObject.MessageObjectPrefix = $MessageObject.MessagePrefix.Trim() +
                $MessageObject.IndentationString + ' '
            }

            Write-Output $MessageObject

        }
        catch {

            Write-ExceptionMessage -e $_

        }

    }
}
