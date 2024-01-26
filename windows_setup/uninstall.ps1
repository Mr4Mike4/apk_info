
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
    Start-Process powershell -Verb runAs -ArgumentList "-NoProfile -NoExit -File `"$PSCommandPath`""
    Break
}

if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\.apk") -eq $true) { 
    Remove-Item "HKLM:\SOFTWARE\Classes\.apk" -Recurse
};
if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\AndroidICO") -eq $true) { 
    Remove-Item "HKLM:\SOFTWARE\Classes\AndroidICO" -Recurse
};
