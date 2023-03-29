## Copyright (c) 2017, 2021 Pieter Wuille (js)
## Copyright (c) 2023, Jared Poeppelman (js to powershell)
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
## THE SOFTWARE.
## Credit: https://github.com/sipa/bech32/blob/master/ref/javascript/bech32.js

$CHARSET = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l'

[sbyte[]]$CHARSET_REV = @(
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  15, -1, 10, 17, 21, 20, 26, 30,  7,  5, -1, -1, -1, -1, -1, -1,
  -1, 29, -1, 24, 13, 25,  9,  8, 23, -1, 18, 22, 31, 27, 19, -1,
   1,  0,  3, 16, 11, 28, 12, 14,  6,  4,  2, -1, -1, -1, -1, -1,
  -1, 29, -1, 24, 13, 25,  9,  8, 23, -1, 18, 22, 31, 27, 19, -1,
   1,  0,  3, 16, 11, 28, 12, 14,  6,  4,  2, -1, -1, -1, -1, -1
)

$GENERATOR = @(0x3b6a57b2, 0x26508e6d, 0x1ea119fa, 0x3d4233dd, 0x2a1462b3)

$encodings = @{
    BECH32 = "bech32"
    BECH32M = "bech32m"
}

enum Bech32_Encoding {
  bech32 = 1
  bech32m = 0x2bc830a3
}

function [int]getEncodingConst ([string]$enc) {
    <#
    if ($enc -eq $encodings.BECH32) {
        return 1
    } elseif ($enc -eq $encodings.BECH32M) {
        return 0x2bc830a3
    } else {
        return $null
    }
    #>
    return ($enc -as [int])
}

function  [int]polymod ([string]$values) {
    [int]$chk = 1
    for ($p = 0; $p -lt $values.Length; ++$p) {
        [int]$top = $chk -shr 25
        $chk = (($chk -band 0x1ffffff) -shl 5) -bxor $values[$p]
        for ($i = 0; $i -lt 5; ++$i) {
            if (($top -shr $i) -band 1) {
                $chk = $chk -bxor $GENERATOR[$i]
            }
        }
    }
    return $chk
}

function [byte[]]hrpExpand ([string]$hrp) {  
    [byte[]]$ret = @()
    #$bigInt = [Numerics.BigInteger]::Zero
    for ($p = 0; $p -lt $hrp.Length; ++$p) {
      #$ret += [byte][char]($hrp[$p] -shr 5)
      $ret[$p] = [byte]($hrp[$p] -shr 5)
    }
    $ret += 0
    for ($p = 0; $p -lt $hrp.Length; ++$p) {
      #$ret += [byte][char]($hrp[$p] -band 31)
      $ret[$p] = [byte]($hrp[$p] -band 31)
    }
    return $ret
}

function [Bech32_Encoding]verifyChecksum ([string]$hrp, [byte[]]$data) {
  [int]$chk = polymod([string](hrpExpand($hrp),$data))
  return $chk
  #return ((polymod(((hrpExpand($hrp)) + $data))) -eq (getEncodingConst($enc)))
}

function [byte[]]createChecksum ([string]$hrp, [byte[]]$data, [Bech32_Encoding]$enc) {
  $values = (hrpExpand($hrp)) + $data + [string]@(0,0,0,0,0,0)
  #$mod = polymod($values) -bxor (getEncodingConst($enc))
  [int]$mod = (polymod($values) -bxor ($enc -as [int]))
  $ret = @()
  for ($i=0; $i -lt 6; ++$i) {
      #$ret += (($mod -shr (5 * (5 - $i))) -band 31)
      $ret[$i] = (($mod -shr (5 * (5 - $i))) -band 31)
    }
    return $ret
}

function [string]ConvertTo-Bech32 ([string]$hrp, [byte[]]$data, [Bech32_Encoding]$enc) {
  #Write-Output "$([string]$hrp)'1$(([string]([int[]]$data + [int[]](createChecksum($hrp,$data,$enc))))|%{[char]$CHARSET[$_]}|Out-String)" 
  [byte[]]$combined = $data + @(createChecksum($hrp, $data, ($enc -as [int])))
  [string]$ret = $hrp + '1'

  for ($p = 0; $p -lt $combined.length; ++$p) {
    #$ret += $CHARSET[($combined[$p])]
    $ret += $CHARSET[$p]
  }
  return $ret
}

function [string]ConvertFrom-Bech32 ([string]$bechString, [Bech32_Encoding]$enc) {
  [bool]$has_lower = $false
  [bool]$has_upper = $false
  for ($p = 0; $p -lt $bechString.length; ++$p) {
    $charCode = [byte][char]($bechString[$p])
    
    if ($charCode -lt 33 -or $charCode -gt 126) {
      return $null
    }
    if ($charCode -ge 97 -and $charCode -le 122) {
        $has_lower = $true
    }
    if ($charCode -ge 65 -and $charCode -le 90) {
        $has_upper = $true
    }
  }
  if ($has_lower -and $has_upper) {
    return $null
  }
  
  $bechString = $bechString.ToLower()
  
  $pos = $bechString.lastIndexOf('1')
  if ($pos -lt 1 -or $pos + 7 -gt $bechString.length -or $bechString.length -gt 90) {
    return $null
  }
  [string]$hrp = $bechString.substring(0, $pos)
  [int[]]$data = @()
  for ($p = $pos + 1; $p -lt $bechString.length; ++$p) {
    #$d = $CHARSET.indexOf($bechString[$p])
    [byte]$c = $bechString[$p + $pos +1]
    $d = $CHARSET_REV[$c]
    if ($d -eq -1) {
      return $null
    }
    #$data += $d
    $data[$p] = $d
  }
  <#
  if (!(verifyChecksum($hrp, $data, $enc))) {
    return $null
  }
  #>
  $ofs=''
  return @{
    hrp=$hrp
    data=($data[0..($data.length - 6)])
  }
}