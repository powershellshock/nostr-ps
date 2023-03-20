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
            @(New-NostrEventTag -Type Event -Target 'abcdef0123456789abcdef0123456789' -RelayUrl 'http://invalid.example'), 
            @(New-NostrEventTag -Type Pubkey -Target '0123456789abcdef0123456789abcdef' -RelayUrl 'http://invalid.example')
        )
        content = $Content
        sig = '1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef'
    }
    $output = $event | ConvertTo-Json  #-Compress # ADD COMPRESSION HERE LATER**********************************************************************
    $output
    Write-Verbose ("Bytes: {0}" -f [System.Text.Encoding]::UTF8.GetByteCount($output))
    #Write-Verbose $event.tags
}