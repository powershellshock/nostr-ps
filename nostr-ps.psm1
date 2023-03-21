﻿enum Event_Kind {
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

# Includes
. "$PSScriptRoot\private\Update-NostrEventHash.ps1"
. "$PSScriptRoot\private\New-NostrEventTag.ps1"
. "$PSScriptRoot\public\ConvertFrom-Bech32.ps1"
. "$PSScriptRoot\public\ConvertTo-EpochSeconds.ps1"
. "$PSScriptRoot\public\Get-NostrKey.ps1"
. "$PSScriptRoot\public\New-NostrEvent.ps1"

# Functions to export
$ExportedCommands = @(
    'ConvertFrom-Bech32',
    'ConvertTo-EpochSeconds',
    'Get-NostrKey',
    'New-NostrEvent',
    'New-NostrEventTag',
    'Test-NostrModule',
    'Update-NostrEventHash'
)
$ExportedCommands | ForEach-Object {
    Export-ModuleMember -Function $_
}

# Variables to export
Export-ModuleMember -Variable nostrId

# Aliases to export
Export-ModuleMember -Alias *