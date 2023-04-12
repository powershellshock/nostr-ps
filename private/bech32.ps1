Add-Type -LiteralPath .\private\bech32.cs

<# 
Add-Type -AssemblyName System.Printing
Add-Type -AssemblyName ReachFramework

Invoke-Expression @'
    using namespace System.Management
    using namespace System.Printing

    Class PrinterObject
    {
        [string]$Name
        [PrintServer]$Server
        [PrintQueue]$Queue
        [PrintTicket]$Ticket
        [ManagementObject]$Unit
        [bool]$IsDefault
    }
'@

#public static string EncodeBech32(byte witnessVersion, byte[] witnessProgram, bool isP2PKH, bool mainnet);
public static byte[] DecodeBech32(string addr);
#>