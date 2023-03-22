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
    begin {}
    
    process {
        $Bech32Prefix = $Bech32.Split('1')[0]
        $Bech32Value = $Bech32.Split('1')[1]

        #$hex = [System.BitConverter]::ToString([System.Convert]::FromBase64String($Bech32Value))
        
        #$hex = $hex -replace '-'
        
        #$hex

        # Need to implement proper bech32 decoding above
        'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23' # my pub key in hex (for now)        
    }

    end {}
}