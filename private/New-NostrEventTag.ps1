function New-NostrEventTag {
    [CmdletBinding()]
    Param(
        [Parameter(
            HelpMessage = 'The type of event to be generated.',
            ValueFromPipeline=$true,
            Position=0,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('event','pubkey','coordinates','reference','hashtag','geohash','random','subject','identifier','expiryTime')]
        [string]
        $Type,

        [Parameter(
            HelpMessage = 'Hex id of event or public key or subscription to be referenced by this tag.',
            ValueFromPipeline=$true,
            Position=1,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(32,64)]
        [ValidatePattern('[A-Fa-f0-9]')]
        [string]$Target,

        [Parameter(
            HelpMessage = '(Optional) URL of recommended relay',
            ValueFromPipeline=$true,
            Position=2,
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(0,255)]
        [string]$RelayUrl=""
    )  
    Process {
        $Target = $Target.ToLower()

        switch ($Type) {
            event       {@("e",$Target,$RelayUrl,$Marker)}
            pubkey      {@("p",$Target,$RelayUrl)}
            coordinates {@("a",$Target,$RelayUrl)}
            reference   {@("r",$Target)}
            hashtag     {@("t",$Target)}
            geohash     {@("g",$Target)}
            random      {@("nonce",$Target)}
            subject     {@("subject",$Target)}
            identifier  {@("d",$Target)}
            expiryTime  {@("expiration",$Target)}
        }
    }
}