function New-NostrEvent {
    [CmdletBinding()]
    Param(
        [Parameter(
            HelpMessage = 'PSCredential object containing the npub (address) and nsec (private key).',
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Session = $nostrId,
        
        [Parameter(
            HelpMessage = 'Kind of the nostr event. Each kind has a corresponding integer value. https://github.com/nostr-protocol/nips#event-kinds',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Event_Kind]
        $Kind,

        [Parameter(
            HelpMessage = 'One or more event tags for the event (event, pubkey, etc).',
            Mandatory=$false)]
        [array]
        $Tags = @(),

        [Parameter(
            HelpMessage = 'Arbitrary content of the event.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Content
    )
    #$nsec = $nostrId.GetNetworkCredential().Password

    $nostrEvent = [ordered]@{
        id = ''
        pubkey = $nostrId.UserName | ConvertFrom-Bech32
        created_at = [math]::Round((Get-Date -UFormat %s),0)
        kind = $Kind -as [int]
        tags = $Tags
        content = $Content
        sig = ''
    }
    
    $nostrEvent = Update-NostrEventHash $nostrEvent
    
    $output = $nostrEvent | ConvertTo-Json -Compress
    
    $output
    Write-Verbose ("Bytes: {0}" -f [System.Text.Encoding]::UTF8.GetByteCount($output))
}