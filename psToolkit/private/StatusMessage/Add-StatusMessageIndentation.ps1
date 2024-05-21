function Add-StatusMessageIndentation {
    <#
    .DESCRIPTION
        Indents the message by the number of characters specified using the IndentationCharacter parameter.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    process {

        if ( $MessageObject.IndentationLevel -gt 0 ) {

            $prefix = $MessageObject.IndentationString * $MessageObject.IndentationLevel

            $MessageObject.Message = $( '{0} {1}' -f $prefix, $MessageObject.Message )

        }

        Write-Output $MessageObject

    }
}
