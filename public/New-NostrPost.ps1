function New-NostrPost {
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Session = $nostrId,

        [Parameter(
            HelpMessage = 'Text message to be posted.',
            Position=0,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $PostContent
    )

    New-NostrEvent -Kind text_note -Content $PostContent
}