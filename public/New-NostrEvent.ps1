function New-NostrEvent {
    [CmdletBinding()]
    [OutputType([array])]
    Param(
        [Parameter(
            HelpMessage = 'PSCredential object containing the npub (address) and nsec (private key).',
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$Credential = $nostrId,
        
        [Parameter(
            HelpMessage = 'Basic event kind of the nostr event. Each kind has a corresponding integer value.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Event_Kind]
        $Kind,

        [Parameter(
            HelpMessage = 'One or more tags for the event (event, pubkey, etc)',
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [array]
        $Tags,

        [Parameter(
            HelpMessage = 'Arbitrary content of the event.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Content
    )
    $nsec = $nostrId.GetNetworkCredential().Password

    $nostrEvent = [ordered]@{
        id = ''  # TO BE COMPUTED
        pubkey = $nostrId.GetNetworkCredential().username | ConvertFrom-Bech32
        created_at = [math]::Round((Get-Date -UFormat %s),0)
        kind = $Kind -as [int]
        tags = $Tags
        content = $Content
        sig = '1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef'
    }
    
    $nostrEvent = Update-NostrEventHash $nostrEvent
    
    $output = $nostrEvent | ConvertTo-Json #-Compress
    
    $output
    Write-Verbose ("Bytes: {0}" -f [System.Text.Encoding]::UTF8.GetByteCount($output))
}