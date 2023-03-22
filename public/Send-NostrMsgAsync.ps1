function Send-NostrMsgAsync {
    [CmdletBinding()]
    Param(
        [Parameter(
            HelpMessage = 'PSCredential object containing the npub (address) and nsec (private key).',
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Session = $nostrId,

        [Parameter(
            Mandatory=$true)]
        [ValidateSet('EVENT','REQ','CLOSE','AUTH', IgnoreCase = $false)]
        [string]
        $MessageType
    )
    Begin {}

    Process {
        $myTags = @(
            @(New-NostrEventTag -Type Event -Target 'abcdef0123456789abcdef0123456789' -RelayUrl 'wss://eden.nostr.land'),
            @(New-NostrEventTag -Type Pubkey -Target '0123456789abcdef0123456789abcdef' -RelayUrl 'wss://eden.nostr.land')
        )
        $test = New-NostrEvent - -Kind text_note -Tags $myTags -Content 'Hello, world!' -Verbose
        $test
    }

    End {}
}