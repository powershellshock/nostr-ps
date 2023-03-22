
$charSet = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l'
$generator = @(0x3b6a57b2, 0x26508e6d, 0x1ea119fa, 0x3d4233dd, 0x2a1462b3)
$encodings = @{bech32 = 'bech32'; bech32m = 'bech32m'}


function getEncodingConst($enc) {
  if ($enc -eq $encodings.BECH32) {
    return 1
  } 
  elseif ($enc -eq $encodings.BECH32M) {
    return 0x2bc830a3
  } 
  else {
    return $null
  }
}

function polymod($values) {
  $chk = 1

  for ($p = 0; $p -lt $values.length; $p++) {
    $top = $chk -shr 25
    $chk = ($chk -and 0x1ffffff) -shl 5 -xor $values[$p]
    for ($i = 0; $i -lt 5; $i++) {
      if (($top -shr $i) -and 1) {
        $chk -xor $generator[$i]
      }
    }
  }
  return $chk
}

<#
function hrpExpand (hrp) {
  var ret = [];
  var p;
  for (p = 0; p < hrp.length; ++p) {
    ret.push(hrp.charCodeAt(p) >> 5);
  }
  ret.push(0);
  for (p = 0; p < hrp.length; ++p) {
    ret.push(hrp.charCodeAt(p) & 31);
  }
  return ret;
}

function verifyChecksum (hrp, data, enc) {
  return polymod(hrpExpand(hrp).concat(data)) === getEncodingConst(enc);
}

function createChecksum (hrp, data, enc) {
  var values = hrpExpand(hrp).concat(data).concat([0, 0, 0, 0, 0, 0]);
  var mod = polymod(values) ^ getEncodingConst(enc);
  var ret = [];
  for (var p = 0; p < 6; ++p) {
    ret.push((mod >> 5 * (5 - p)) & 31);
  }
  return ret;
}

function encode (hrp, data, enc) {
  var combined = data.concat(createChecksum(hrp, data, enc));
  var ret = hrp + '1';
  for (var p = 0; p < combined.length; ++p) {
    ret += CHARSET.charAt(combined[p]);
  }
  return ret;
}

function decode (bechString, enc) {
  var p;
  var has_lower = false;
  var has_upper = false;
  for (p = 0; p < bechString.length; ++p) {
    if (bechString.charCodeAt(p) < 33 || bechString.charCodeAt(p) > 126) {
      return null;
    }
    if (bechString.charCodeAt(p) >= 97 && bechString.charCodeAt(p) <= 122) {
        has_lower = true;
    }
    if (bechString.charCodeAt(p) >= 65 && bechString.charCodeAt(p) <= 90) {
        has_upper = true;
    }
  }
  if (has_lower && has_upper) {
    return null;
  }
  bechString = bechString.toLowerCase();
  var pos = bechString.lastIndexOf('1');
  if (pos < 1 || pos + 7 > bechString.length || bechString.length > 90) {
    return null;
  }
  var hrp = bechString.substring(0, pos);
  var data = [];
  for (p = pos + 1; p < bechString.length; ++p) {
    var d = CHARSET.indexOf(bechString.charAt(p));
    if (d === -1) {
      return null;
    }
    data.push(d);
  }
  if (!verifyChecksum(hrp, data, enc)) {
    return null;
  }
  return {hrp: hrp, data: data.slice(0, data.length - 6)};
}
#>

function ConvertFrom-Bech32 {
    [CmdletBinding()]
    param(
        [Parameter(
            HelpMessage = 'Bech32 string to be decoded',
            Position=0,
            ValueFromPipeline=$true,
            Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(8,2048)]
        [ValidateScript({
            ($_.Split($separator)[0]).Length -ge 1 -and ($_.Split($separator)[0]).Length -le 83
        })]
        [string]$Bech32
    )
    begin {


      #$js = Create-ScriptEngine "JScript" $jscode
    }
    
    process {
        <#
        # Split Bech32 string into human-readable part (HRP) and data part
        $hrp = $Bech32.Split($separator)[0]
        Write-Verbose "Bech32 HRP: $hrp"
        Write-Verbose ("Bech32 HRP length: {0}" -f $hrp.Length)
                
        $data = $Bech32.Split($separator)[1]
        Write-Verbose "Bech32 data part: $hrp"
        Write-Verbose ("Bech32 data part length: {0}" -f $hrp.Length)
        #>

        # Need to implement proper bech32 decoding above
        'b726e71bce585201181ace89326ae428406cee071395f9bf12b62b62d0449b23' # my pub key in hex (for now)      
        
        #$js.decode($Bech32)

    }

    end {}
}