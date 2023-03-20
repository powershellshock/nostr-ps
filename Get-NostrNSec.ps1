function Get-NostrNsec {
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSCredential])]
    param
    (
        # npub
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$npub,

        # Send the PSCredential object out through the pipeline for further processing.
        [Parameter(Mandatory=$false)]
        [switch]$PassThru
    )
    process
    {
        # If tenant URI is specified, prompt for OAuth token and get it all into a global variable
        if ($npub) {
            [System.Management.Automation.PSCredential]$Global:nostrId = Get-Credential -UserName $npub -Message "Enter the nsec for $npub"
        }

        # Else, prompt for both the tenant and OAuth token and get it all into a global variable
        else {
            [System.Management.Automation.PSCredential]$Global:nostrId = Get-Credential -Message "Enter the npub and nsec"
        }

        # If -PassThru is specified, write the credential object to the pipeline (the global variable will also be exported to the calling session with Export-ModuleMember)
        if ($PassThru) {
            $nostrId
        }
    }
}