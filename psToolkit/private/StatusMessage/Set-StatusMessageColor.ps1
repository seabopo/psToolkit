function Set-StatusMessageColor {
    <#
    .DESCRIPTION
        Sets the color of the status message based on the message type.
    #>

    [OutputType([HashTable])]
    [CmdletBinding()]
    param ( [Parameter(Mandatory,ValueFromPipeline)] [HashTable] $MessageObject )

    process {

        try {

            $MessageObject.MessageColor = switch ( $MessageObject.Type )
                                        {
                                            "Header"      { "Magenta"    }
                                            "Process"     { "Cyan"       }
                                            "Action"      { "Gray"       }
                                            "Information" { "DarkGray"   }
                                            "Debug"       { "DarkGray"   }
                                            "Success"     { "DarkGreen"  }
                                            "Warning"     { "DarkYellow" }
                                            "Failure"     { "DarkRed"    }
                                            "Error"       { "Red"        }
                                            "Exception"   { "Red"        }
                                            default       { "Gray"       }
                                        }

            Write-Output $MessageObject

        }
        catch {

            Write-ExceptionMessage -e $_

        }

    }
}

# write-host 'Some Test Text in DarkBlue   ' -ForegroundColor DarkBlue
# write-host 'Some Test Text in White      ' -ForegroundColor White
