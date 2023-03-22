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
        [System.Management.Automation.PSCredential]$Global:nostrId = Get-Credential -UserName $npub -Message "Enter the nsec (private key) for address: $npub"    

        $nostrId.UserName = $nostrId.GetNetworkCredential().UserName | ConvertFrom-Bech32

        # If -PassThru is specified, write the credential object to the pipeline (the global variable will also be exported to the calling session with Export-ModuleMember)
        if ($PassThru) {
            $nostrId
        }
    }
}