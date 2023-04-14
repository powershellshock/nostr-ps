
$BECH32_VALID_ADDRESS_DATA = @(
    @{bech32='BC1QW508D6QEJXTDG4Y5R3ZARVARY0C5XW7KV8F3T4'; hexkey='0014751e76e8199196d454941c45d1b3a323f1433bd6'}
    @{bech32='tb1qrp33g0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3q0sl5k7'; hexkey= '00201863143c14c5166804bd19203356da136c985678cd4d27a1b8c6329604903262'}
    @{bech32='bc1pw508d6qejxtdg4y5r3zarvary0c5xw7kw508d6qejxtdg4y5r3zarvary0c5xw7k7grplx'; hexkey= '5128751e76e8199196d454941c45d1b3a323f1433bd6751e76e8199196d454941c45d1b3a323f1433bd6'}
    @{bech32='BC1SW50QA3JX3S'; hexkey= '6002751e'}
    @{bech32='bc1zw508d6qejxtdg4y5r3zarvaryvg6kdaj'; hexkey= '5210751e76e8199196d454941c45d1b3a323'}
    @{bech32='tb1qqqqqp399et2xygdj5xreqhjjvcmzhxw4aywxecjdzew6hylgvsesrxh6hy'; hexkey= '0020000000c4a5cad46221b2a187905e5266362b99d5e91c6ce24d165dab93e86433'}
    @{bech32='npub1kunwwx7wtpfqzxq6e6yny6hy9pqxems8zw2ln0cjkc4k95zynv3s4kwd3c'; hexkey= 'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23'}
    @{bech32='nsec1vl029mgpspedva04g90vltkh6fvh240zqtv9k0t9af8935ke9laqsnlfe5'; hexkey= '67dea2ed018072d675f5415ecfaed7d2597555e202d85b3d65ea4e58d2d92ffa'}
    @{bech32='nprofile1qqsrhuxx8l9ex335q7he0f09aej04zpazpl0ne2cgukyawd24mayt8gpp4mhxue69uhhytnc9e3k7mgpz4mhxue69uhkg6nzv9ejuumpv34kytnrdaksjlyr9p'; hexkey= '3bf0c63fcb93463407af97a5e5ee64fa883d107ef9e558472c4eb9aaaefa459d'}
)

$BECH32_VALID_ADDRESS_DATA | ForEach-Object {ConvertFrom-Bech32 -BechString ($_.bech32) -enc Bech32}

<# 
$d = ConvertFrom-Bech32 -BechString 'nsec1vl029mgpspedva04g90vltkh6fvh240zqtv9k0t9af8935ke9laqsnlfe5' -enc BECH32
$d2 = $d.data
$d2
 #>


#($d.data | ForEach-Object {"{0:x2}" -f $_}) -join ''
#[System.Text.Encoding]::UTF8.GetString($d.data)

#$d2 = $d.data | ForEach-Object{[System.BitConverter]::GetBytes($_)}


#($d2 | ForEach-Object {[Convert]::ToString($_, 16)}) -join ''
