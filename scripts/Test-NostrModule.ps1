function Test-NostrModule {

  
  $Global:testOutput = New-NostrPost 'Hello, world!  Sent from nostr-ps, the Powershell nostr client. https://github.com/powershellshock/nostr-ps' -Verbose


  $Global:expectedHexKey = 'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23'

  if (($testOutput | ConvertFrom-Json).pubkey -eq $expectedHexKey) {
    Write-Host -ForegroundColor Green "Bech32 decode temp workaround: PASSED"
  }
  else {
    Write-Host -ForegroundColor Red "Bech32 decode temp workaround: FAILED"
  }


  # Test ConvertFrom-Bech32
  if ('7e7e9c42a91bfef19fa929e5fda1b72e0ebc1a4c1141673e2794234d86addf4e' -eq (ConvertFrom-Bech32 'npub10elfcs4fr0l0r8af98jlmgdh9c8tcxjvz9qkw038js35mp4dma8qzvjptg' -enc bech32).data) {
    Write-Host -ForegroundColor Green "Bech32 npub1 decoding: PASSED"
  }
  else {
    Write-Host -ForegroundColor Red "Bech32 npub1 decoding: FAILED"
  }

  # Test ConvertFrom-Bech32 
  if ('67dea2ed018072d675f5415ecfaed7d2597555e202d85b3d65ea4e58d2d92ffa' -eq (ConvertFrom-Bech32 'nsec1vl029mgpspedva04g90vltkh6fvh240zqtv9k0t9af8935ke9laqsnlfe5' -enc bech32).data) {
    Write-Host -ForegroundColor Green "Bech32 nsec1 decoding: PASSED"
  }
  else {
    Write-Host -ForegroundColor Red "Bech32 nsec1 decoding: FAILED"
  }
}

#Get-NostrNsec -npub 'npub1kunwwx7wtpfqzxq6e6yny6hy9pqxems8zw2ln0cjkc4k95zynv3s4kwd3c' -PassThru | Export-Clixml C:\Users\jared\nostr.cred


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
## SAMPLE POST
["EVENT",{
  "id":"e9b1fc485783bf6d4e1fbf19b71a8f7943db8c92377b66f6ff89d7797ba9a515",
  "pubkey":"b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23",
  "created_at":1679347355,
  "kind":1,
  "tags":[],
  "content":"Test message from snort",
  "sig":"26a4e9c4bfcc52ea89e37d5c5424331148d95563443ad8a34f34be68a552fdd6b22681c69e5c8f970050961a5c87e9c05f3775d8e882b5663857daaeb6fff395"
}]


## New-NostrPost
{
  "id":"e9b1fc485783bf6d4e1fbf19b71a8f7943db8c92377b66f6ff89d7797ba9a515",
  "pubkey":"npub1kunwwx7wtpfqzxq6e6yny6hy9pqxems8zw2ln0cjkc4k95zynv3s4kwd3c",
  "created_at":1679458467.0,
  "kind":1,
  "tags":[],
  "content":"Hello, world!  Sent from nostr-ps, the Powershell nostr client.",
  "sig":"26a4e9c4bfcc52ea89e37d5c5424331148d95563443ad8a34f34be68a552fdd6b22681c69e5c8f970050961a5c87e9c05f3775d8e882b5663857daaeb6fff395"
}





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