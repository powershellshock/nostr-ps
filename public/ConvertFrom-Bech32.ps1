function ConvertFrom-Bech32 {
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        #
        [Parameter(
            HelpMessage = 'Bech32 value to be decoded to hex',
            Position=0,
            ValueFromPipeline=$true,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(63,63)]
        [string]$Bech32
    )
    Process {
        'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23' # my pub key in hex
        # Need to implement bech32 decoding or convert-your-own-key
    }
}