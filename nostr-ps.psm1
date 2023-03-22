enum Event_Kind {
    set_metadata = 0
    text_note = 1
    recommend_relay = 2
    contact_list = 3
    encrypted_direct_msg = 4
    delete_req = 5
    react = 7
    badge_award = 8
    channel_create = 40
    channel_metadata = 41
    channel_msg = 42
    channel_hide_msg = 43
    mute_user = 44
    report = 1984
    zap_req = 9734
    zap = 9735
    mute_list = 10000
    pin_list = 10001
    relay_list_metadata = 10002
    client_authn = 22242
    nostr_connect = 24133
    categorized_people_list = 30000
    categorized_bookmarks_list = 30001
    profile_badges = 30008
    badge_definition = 30009
    long_content = 30023
    app_specific_data = 30078
}

# Bech32 
$Bech32Prefixes = @('npub','nsec','note','nevent','nprofile','nrelay','naddr')
$separator = '1'

# Includes
. "$PSScriptRoot\private\New-NostrEventTag.ps1"
. "$PSScriptRoot\private\Update-NostrEventHash.ps1"
. "$PSScriptRoot\public\ConvertFrom-Bech32.ps1"
. "$PSScriptRoot\public\ConvertTo-EpochSeconds.ps1"
. "$PSScriptRoot\public\Import-NostrKey.ps1"
. "$PSScriptRoot\public\New-NostrEvent.ps1"
. "$PSScriptRoot\public\New-NostrPost.ps1"
. "$PSScriptRoot\public\Send-NostrMsgAsync.ps1"
. "$PSScriptRoot\public\Receive-NostrMsg.ps1"
. "$PSScriptRoot\scripts\Test-NostrModule.ps1"

# Export functions for user
$ExportedCommands = @(
    'New-NostrEventTag',
    'Update-NostrEventHash',
    'ConvertFrom-Bech32',
    'ConvertTo-EpochSeconds',
    'Import-NostrKey',
    'New-NostrEvent',
    'New-NostrPost',
    'Send-NostrMSgAsync',
    'Receive-NostrMsg',
    'Test-NostrModule'
)
$ExportedCommands | ForEach-Object {
    Export-ModuleMember -Function $_
}

# Export the PSCredential object used for secure nsec (private key) storage
Export-ModuleMember -Variable nostrSession

# Aliases to export
Export-ModuleMember -Alias *