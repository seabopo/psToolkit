# psToolkit
A PowerShell module of stand-alone helper functions.

### Initialize-PipelineObject 
Creates a Hashtable (or appends to a passed Hashtable) a set of key/value pairs based on the parameters
of the calling function. This object is intended to be a data collection mechanism that is passed through 
a series of functions via the pipeline to provide easy data access and eliminate parameter chasing. It also 
adds an 'invocation' child object which contains an entry for each function invocation the object was used for.
The invocation child objects contain information useful for error reporting and exception logging.

### Write-StatusMessage
Writes a formatted status message to the console. Messages can be indented, colorized and contain objects
which are converted to JSON for debug logging.
