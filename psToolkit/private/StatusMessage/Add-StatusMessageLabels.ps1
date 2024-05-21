function Add-StatusMessageLabels {
    <#
    .DESCRIPTION
        Adds a prefix to a status message based on the message type.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    process {

        if ( $MessageObject.Labels ) {

            $MessageObject.Message = switch ( $MessageObject.Type )
                                     {
                                         'Success'   { $( "SUCCESS: {0}"   -f $MessageObject.Message ) }
                                         'Warning'   { $( "WARNING: {0}"   -f $MessageObject.Message ) }
                                         'Failure'   { $( "FAILURE: {0}"   -f $MessageObject.Message ) }
                                         'Error'     { $( "ERROR: {0}"     -f $MessageObject.Message ) }
                                         'Exception' { $( "EXCEPTION: {0}" -f $MessageObject.Message ) }
                                         default     { $MessageObject.Message }
                                     }

        }

        Write-Output $MessageObject

    }
}
