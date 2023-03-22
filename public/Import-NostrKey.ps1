function Import-NostrKey {
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSCredential])]
    param
    (
        #
        [Parameter(
            HelpMessage = 'The npub (address) for the nsec (private key)',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(63,63)]
        [ValidateScript({
            ($_.GetNetworkCredential().username).StartsWith('npub')
        })]
        [string]
        $npub,

        # Send the PSCredential object out through the pipeline for further processing.
        [Parameter(Mandatory=$false)]
        [switch]
        $PassThru
    )
    process
    {
        $userInput = Get-Credential -UserName $npub -Message "Enter the nsec (private key) for address: $npub"

        $npubHex = $userInput.UserName | ConvertFrom-Bech32
        $nsecHex = $userInput.GetNetworkCredential().Password | ConvertTo-SecureString -AsPlainText -Force

        $nostrId = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $npubHex,$nsecHex

        # If -PassThru is specified, write the PSCredential object to the pipeline
        if ($PassThru) {
            $nostrId
        }
    }
}