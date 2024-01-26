
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
    Start-Process powershell -Verb runAs -ArgumentList "-NoProfile -NoExit -File `"$PSCommandPath`""
    Break
}

$appPath = "$PSScriptRoot\apk_info.exe"
$icoPath = "$PSScriptRoot\android.ico"

if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\.apk") -ne $true) { 
    New-Item "HKLM:\SOFTWARE\Classes\.apk" -force -ea SilentlyContinue
};
if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\AndroidICO") -ne $true) { 
    New-Item "HKLM:\SOFTWARE\Classes\AndroidICO" -force -ea SilentlyContinue
};
if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\AndroidICO\DefaultIcon") -ne $true) { 
    New-Item "HKLM:\SOFTWARE\Classes\AndroidICO\DefaultIcon" -force -ea SilentlyContinue
};
if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\AndroidICO\shell") -ne $true) { 
    New-Item "HKLM:\SOFTWARE\Classes\AndroidICO\shell" -force -ea SilentlyContinue
};
if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\AndroidICO\shell\open") -ne $true) { 
    New-Item "HKLM:\SOFTWARE\Classes\AndroidICO\shell\open" -force -ea SilentlyContinue
};
if ((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\AndroidICO\shell\open\command") -ne $true) { 
    New-Item "HKLM:\SOFTWARE\Classes\AndroidICO\shell\open\command" -force -ea SilentlyContinue
};

New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\.apk' -Name '(default)' -Value 'AndroidICO' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\AndroidICO' -Name '(default)' -Value 'Android File' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\AndroidICO\DefaultIcon' -Name '(default)' -Value "`"$icoPath`",0" -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\AndroidICO\shell\open\command' -Name '(default)' -Value "`"$appPath`" `"%1`"" -PropertyType String -Force -ea SilentlyContinue;
