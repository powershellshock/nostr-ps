<#
.Synopsis
    Converts a [datetime] to epoch seconds
.DESCRIPTION
    ConvertTo-EpochSeconds returns an [int] value representing the seconds since 1970-01-01
#>
function ConvertTo-EpochSeconds {
    [CmdletBinding()]
    [OutputType([int])]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        [datetime]$Timestamp
    )
    #(New-TimeSpan -Start (Get-Date "01/01/1970") -End (Get-Date $Timestamp)).TotalSeconds  
    [math]::Round((Get-Date $Timestamp -UFormat %s),0)
}