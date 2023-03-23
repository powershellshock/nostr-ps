
function ConvertFrom-Bech32-deprecated {
    [CmdletBinding()]
    param(
        [Parameter(
            HelpMessage = 'Bech32 string to be decoded',
            Position=0,
            ValueFromPipeline=$true,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(8,2048)]
        [ValidateScript({
            ($_.Split($separator)[0]).Length -ge 1 -and ($_.Split($separator)[0]).Length -le 83
        })]
        [string]$Bech32
    )
    
    #decode -bechString $Bech32 -enc bech32

    # Need to implement proper bech32 decoding above
    'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23' # my pub key in hex (for now)      
}