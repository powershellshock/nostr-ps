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

function New-NostrEventTag {
    [CmdletBinding()]
    [OutputType([string[]])]
    Param(
        [Parameter(
            HelpMessage = 'The type of event to be generated.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Event','Pubkey')]
        [string]
        $Type,

        [Parameter(
            HelpMessage = 'Hex id of event or public key to be referenced by this tag.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^[A-Fa-f0-9]{32}$')]
        [string]$Target,

        [Parameter(
            HelpMessage = '(Optional) URL of recommended relay',
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]

        [string]$RelayUrl
    )
    $tag_id = $Type.ToLower()[1]
    $Target = $Target.ToLower()

    @($tag_id,$Target,$RelayUrl) | ConvertTo-Json -Compress
}

function New-NostrEvent {
    [CmdletBinding()]
    [OutputType([string])]
    Param(
        [Parameter(
            HelpMessage = 'Basic event kind of the nostr event. Each kind has a corresponding integer value.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Basic_Event_Kind]
        $Kind,

        [Parameter(
            HelpMessage = 'Event/pubkey tags for the event.',
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Tags,

        [Parameter(
            HelpMessage = 'Arbitrary content of the event.',
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Content
    )
    
<#
$EventTreatment = switch ( $Kind -as [int] )
{
    {01000 -lte $PSItem -and $PSItem -lt 10000} {'Regular'}
    {10000 -lte $PSItem -and $PSItem -lt 20000} {'Replaceable'}
    {20000 -lte $PSItem -and $PSItem -lt 30000} {'Ephemeral'}
    
}
#>

    $event = @{
        id = '1234567890abcdef1234567890abcdef'  # TO BE COMPUTED
        pubkey = 'fedbca0987654321fedbca0987654321'
        created_at = [math]::Round((Get-Date -UFormat %s),0)
        kind = $Kind -as [int]
        tags = @(
            @('e','abcdef0123456789abcdef0123456789','http://invalid.example:8080')
            New-NostrEventTag -Type Event -Target 'abcdef0123456789abcdef0123456789' -RelayUrl 'http://invalid.example'
            @('p','abcdef0123456789abcdef0123456789','http://invalid.example:8080')
        )
        content = $Content
        sig = '1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef'
    }
    $output = $event | ConvertTo-Json  #-Compress                  # ADD COMPRESSION HERE LATER**********************************************************************
    $output
    Write-Verbose ("Bytes: {0}" -f [System.Text.Encoding]::UTF8.GetByteCount($output))
}


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





























function Format-MacAddress
{
    [CmdletBinding()]
    [OutputType([string])]
    Param
    (
        # MAC address to be formatted. Can be colon/hyphen/space delimited or not delimited 
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(0,17)]
        #[ValidateScript({(($_.Replace(':','')).Replace('-','')).Replace(' ','') -match {^[A-Fa-f0-9]{12}$}})]
        [ValidateScript({($_ -replace ':|-| ','') -match {^[A-Fa-f0-9]{12}$}})]
        [Alias("MacAddress","PhysicalAddress")]
        [string]
        $Address,

        # Optional separator character to use (can be colon ':', hyphen '-', or space ' '). If not specified, no separator will be used.
        [Parameter(Mandatory=$false,
                   Position=1)]
        [ValidateSet(':','-',' ')]
        [char]
        $Separator,

        # Specify output in all upper/lower case
        [Parameter(Mandatory=$false,
                   Position=2)]
        [ValidateSet('Upper','Lower')]
        [string]
        $Case
    )
        
    If ($Case -eq 'Upper') {
        $Address = $Address.ToUpper()
        #Write-Verbose "Format-MacAddress: Upper case was enforced: $Address"
    }

    If ($Case -eq 'Lower') {
        $Address = $Address.ToLower()
        #Write-Verbose "Format-MacAddress: Lower case was enforced: $Address"
    }

    $Address = (($Address.Replace(':','')).Replace('-','')).Replace(' ','')
    #Write-Verbose "Format-MacAddress: Colon (:), hyphen (-), and space ( ) separators removed, if present: $MacAddress"

    $Address = @(($Address[0,1] -join ''),($Address[2,3] -join ''),($Address[4,5] -join ''),($Address[6,7] -join ''),($Address[8,9] -join ''),($Address[10,11] -join '')) -join $Separator
    #Write-Verbose "Format-MacAddress: Address was reconstructed with specified separator: $Address"

    $Address
}