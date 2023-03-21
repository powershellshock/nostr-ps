enum Basic_Event_Kind {
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
# includes
<#
$MyInvocation.MyCommand.Path
$basePath = (Split-Path -Parent -Path $MyInvocation.MyCommand.Path)
Resolve-Path -Path $basePath\private\*.ps1 | ForEach-Object -Process {$_.ProviderPath}
Resolve-Path -Path $basePath\public\*.ps1 | ForEach-Object -Process {$_.ProviderPath}
#>

. "private\New-NostrEventTag.ps1"

. ".\public\ConvertFrom-Bech32.ps1"
. ".\public\Get-NostrKey.ps1"
. ".\public\New-NostrEvent.ps1"


#Get-NostrNsec -npub 'npub1kunwwx7wtpfqzxq6e6yny6hy9pqxems8zw2ln0cjkc4k95zynv3s4kwd3c' -PassThru | Export-Clixml C:\Users\jared\nostr.cred


#
$myTags = @(
  @(New-NostrEventTag -Type Event -Target 'abcdef0123456789abcdef0123456789' -RelayUrl 'wss://eden.nostr.land'),
  @(New-NostrEventTag -Type Pubkey -Target '0123456789abcdef0123456789abcdef' -RelayUrl 'wss://eden.nostr.land')
)

$test = New-NostrEvent -Kind text_note -Tags $myTags -Content 'Hello, world!' -Verbose
$test
#Compare-Object -ReferenceObject ($uncompressedExpected | ConvertFrom-Json) -DifferenceObject ($test | ConvertFrom-Json) 



<#
{
  "id": <32-bytes lowercase hex-encoded sha256 of the serialized event data>
  "pubkey": <32-bytes lowercase hex-encoded public key of the event creator>,
  "created_at": <unix timestamp in seconds>,
  "kind": <integer>,
  "tags": [
    ["e", <32-bytes hex of the id of another event>, <recommended relay URL>],
    ["p", <32-bytes hex of a pubkey>, <recommended relay URL>],
    ... // other kinds of tags may be included later
  ],
  "content": <arbitrary string>,
  "sig": <64-bytes hex of the signature of the sha256 hash of the serialized event data, which is the same as the "id" field>
}
#>
<#
["EVENT",{"id":"e9b1fc485783bf6d4e1fbf19b71a8f7943db8c92377b66f6ff89d7797ba9a515","pubkey":"b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23","created_at":1679347355,"kind":1,"tags":[],"content":"Test message from snort","sig":"26a4e9c4bfcc52ea89e37d5c5424331148d95563443ad8a34f34be68a552fdd6b22681c69e5c8f970050961a5c87e9c05f3775d8e882b5663857daaeb6fff395"}]


["EVENT", {id: "e9b1fc485783bf6d4e1fbf19b71a8f7943db8c92377b66f6ff89d7797ba9a515",…}]
0
: 
"EVENT"
1
: 
{id: "e9b1fc485783bf6d4e1fbf19b71a8f7943db8c92377b66f6ff89d7797ba9a515",…}
content
: 
"Test message from snort"
created_at
: 
1679347355
id
: 
"e9b1fc485783bf6d4e1fbf19b71a8f7943db8c92377b66f6ff89d7797ba9a515"
kind
: 
1
pubkey
: 
"b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23"
sig
: 
"26a4e9c4bfcc52ea89e37d5c5424331148d95563443ad8a34f34be68a552fdd6b22681c69e5c8f970050961a5c87e9c05f3775d8e882b5663857daaeb6fff395"
tags
: 
[]

#>