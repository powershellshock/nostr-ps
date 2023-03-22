function ConvertFrom-Bech32 {
    [CmdletBinding()]
    param
    (
        #
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
    begin {}
    
    process {
        # Split Bech32 string into human-readable part (HRP) and data part
        $hrp = $Bech32.Split($separator)[0]
        Write-Verbose "Bech32 HRP: $hrp"
        Write-Verbose ("Bech32 HRP length: {0}" -f $hrp.Length)
                
        $data = $Bech32.Split($separator)[1]
        Write-Verbose "Bech32 data part: $hrp"
        Write-Verbose ("Bech32 data part length: {0}" -f $hrp.Length)

        <#
        $hex = [System.BitConverter]::ToString([System.Convert]::FromBase64String($Bech32Value))
        $hex = $hex -replace '-'
        $hex
        #>

        # Need to implement proper bech32 decoding above
        'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23' # my pub key in hex (for now)        
    }

    end {}
}