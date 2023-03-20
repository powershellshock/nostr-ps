enum Basic_Event_Kind {
    # NIP-01
    set_metadata = 0
    text_note = 1
    recommend_server = 2

    # NIP-02
    contact_list = 3

    # NIP-04 
    encrypted_direct_message = 4

    # NIP-09
    deletion = 5
    
    # NIP-28
    channel_create = 40
    channel_metadata = 41
    channel_message = 42
    hide_message = 43
    mute_user = 44
     
    # NIP-51
    mute_list = 10000
    pin_list = 10001
    categorized_people_list = 30000
    categorized_bookmarks_list = 30001
    
    # NIP-58
    badge_definition = 30009
    badge_award = 8
    profile_badges = 30008

    # NIP-65
    relay_list_metadata = 10002
}


.\New-NostrEvent.ps1
.\New-NostrEvent.ps1


New-NostrEvent -Kind text_note -Content 'Hello, world!' -Verbose

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