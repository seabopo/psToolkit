function Set-StatusMessageColor {
    <#
    .DESCRIPTION
        Sets the color of the status message based on the message type.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    process {

        $MessageObject.MessageColor = switch ( $MessageObject.Type )
                                      {
                                          "Process"     { "Cyan"    }
                                          "Header"      { "Magenta" }
                                          "Information" { "Gray"    }
                                          "Success"     { "Green"   }
                                          "Warning"     { "Yellow"  }
                                          "Failure"     { "Red"     }
                                          "Error"       { "Red"     }
                                          "Exception"   { "Red"     }
                                          default       { "Gray"    }
                                      }

        Write-Output $MessageObject

    }
}
