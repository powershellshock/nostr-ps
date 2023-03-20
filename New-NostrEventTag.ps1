function New-NostrEventTag {
    [CmdletBinding()]
    Param(
        [Parameter(
            HelpMessage = 'The type of event to be generated.',
            ValueFromPipeline=$true,
            Position=0,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Event','Pubkey')]
        [string]
        $Type,

        [Parameter(
            HelpMessage = 'Hex id of event or public key to be referenced by this tag.',
            ValueFromPipeline=$true,
            Position=1,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^[A-Fa-f0-9]{32}$')]
        [string]$Target,

        [Parameter(
            HelpMessage = '(Optional) URL of recommended relay',
            ValueFromPipeline=$true,
            Position=2,
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]

        [string]$RelayUrl
    )
    Begin {}
    
    Process {
        $tag_id = ($Type.ToLower())[0]
        $Target = $Target.ToLower()

        @($tag_id,$Target,$RelayUrl) #
    }

    End {}
}