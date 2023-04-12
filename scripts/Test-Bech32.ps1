
$BECH32_VALID_ADDRESS_DATA = @(
    @{bech32='BC1QW508D6QEJXTDG4Y5R3ZARVARY0C5XW7KV8F3T4'; hexkey='0014751e76e8199196d454941c45d1b3a323f1433bd6'}
    @{bech32='tb1qrp33g0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3q0sl5k7'; hexkey= '00201863143c14c5166804bd19203356da136c985678cd4d27a1b8c6329604903262'}
    @{bech32='bc1pw508d6qejxtdg4y5r3zarvary0c5xw7kw508d6qejxtdg4y5r3zarvary0c5xw7k7grplx'; hexkey= '5128751e76e8199196d454941c45d1b3a323f1433bd6751e76e8199196d454941c45d1b3a323f1433bd6'}
    @{bech32='BC1SW50QA3JX3S'; hexkey= '6002751e'}
    @{bech32='bc1zw508d6qejxtdg4y5r3zarvaryvg6kdaj'; hexkey= '5210751e76e8199196d454941c45d1b3a323'}
    @{bech32='tb1qqqqqp399et2xygdj5xreqhjjvcmzhxw4aywxecjdzew6hylgvsesrxh6hy'; hexkey= '0020000000c4a5cad46221b2a187905e5266362b99d5e91c6ce24d165dab93e86433'}
)

#$BECH32_VALID_ADDRESS_DATA | ForEach-Object {ConvertFrom-Bech32 -BechString ($_.bech32) -enc Bech32}