
## Credit: https://github.com/sipa/bech32/blob/master/ref/javascript/bech32.js

$CHARSET = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l'
$GENERATOR = @(0x3b6a57b2, 0x26508e6d, 0x1ea119fa, 0x3d4233dd, 0x2a1462b3)

$encodings = @{
    BECH32 = "bech32"
    BECH32M = "bech32m"
}

function getEncodingConst ($enc) {
    if ($enc -eq $encodings.BECH32) {
        return 1
    } elseif ($enc -eq $encodings.BECH32M) {
        return 0x2bc830a3
    } else {
        return $null
    }
}

function polymod ($values) {
    $chk = 1
    for ($p = 0; $p -lt $values.Length; ++$p) {
        $top = $chk -shr 25
        $chk = ($chk -band 0x1ffffff) -shl 5 -bxor $values[$p]
        for ($i = 0; $i -lt 5; ++$i) {
            if (($top -shr $i) -band 1) {
                $chk = $chk -bxor $GENERATOR[$i]
            }
        }
    }
    return $chk
}

function hrpExpand ($hrp) {
    $ret = @()
    for ($p = 0; $p -lt $hrp.Length; ++$p) {
        [void]$ret.Add($hrp[$p] -shr 5)
    }
    [void]$ret.Add(0)
    for ($p = 0; $p -lt $hrp.Length; ++$p) {
        [void]$ret.Add($hrp[$p] -band 31)
    }
    return $ret
}

function verifyChecksum ($hrp, $data, $enc) {
    return (polymod((hrpExpand($hrp)) + @($data)) -eq (getEncodingConst($enc)))
}

function createChecksum ($hrp, $data, $enc) {
    $values = (hrpExpand($hrp)) + @($data) + @(0)*6
    $mod = polymod($values) -bxor (getEncodingConst($enc))
    for ($i=0; $i -lt 6; ++$i) {
        [void]$ret.Add(($mod -shr (5 * (5 - $i))) -band 31)
      }
      return $ret
}

function encode ($hrp, $data, $enc) {
  #Write-Output "$([string]$hrp)'1$(([char[]]([int[]]$data + [int[]](createChecksum($hrp,$data,$enc))))|%{[char]$CHARSET[$_]}|Out-String)"
  
  $combined = $data + @(createChecksum($hrp, $data, $enc))
  $ret = $hrp + '1'
  for ($p = 0; $p -lt $combined.length; ++$p) {
    $ret += $CHARSET[($combined[$p])]
  }
  return $ret
}

function decode ($bechString, $enc) {
  $has_lower = $false
  $has_upper = $false
  
  for ($p = 0; $p -lt $bechString.length; ++$p) {
    if ($bechString[$p] -lt 33 || $bechString[$p] -gt 126) {
      return $null
    }
    if ($bechString[$p] -ge 97 && $bechString[$p] -le 122) {
        $has_lower = $true
    }
    if ($bechString[$p] -ge 65 && $bechString[$p] -le 90) {
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

  $hrp = $bechString.substring(0, $pos)
  $data = @()

  for ($p = pos + 1; $p -lt $bechString.length; ++$p) {
    $d = $CHARSET.indexOf($bechString[$p])
    if ($d -eq -1) {
      return $null
    }
    $data.Add($d)
  }

  if (!verifyChecksum($hrp, $data, $enc)) {
    return $null
  }

  return {hrp: $hrp, data: $data.slice(0, $data.length - 6)}
}