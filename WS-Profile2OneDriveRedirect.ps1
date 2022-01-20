# Set the workstation to silent sign in for OneDrive (https://docs.microsoft.com/en-us/onedrive/use-silent-account-configuration)
$HKLMregistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive'##Path to HKLM keys
$DiskSizeregistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\DiskSpaceCheckThresholdMB'##Path to max disk size key
$TenantGUID = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' # Update with your tenant GUID

if(!(Test-Path $HKLMregistryPath)){New-Item -Path $HKLMregistryPath -Force}
if(!(Test-Path $DiskSizeregistryPath)){New-Item -Path $DiskSizeregistryPath -Force}

New-ItemProperty -Path $HKLMregistryPath -Name 'SilentAccountConfig' -Value '1' -PropertyType DWORD -Force | Out-Null ##Enable silent account configuration
New-ItemProperty -Path $DiskSizeregistryPath -Name $TenantGUID -Value '102400' -PropertyType DWORD -Force | Out-Null ##Set max OneDrive threshold before prompting

# Known Folder Redirection (https://docs.microsoft.com/en-us/onedrive/use-group-policy#silently-move-windows-known-folders-to-onedrive)
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "SilentAccountConfig" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "KFMSilentOptIn" /t REG_SZ /d "1111-2222-3333-4444" /f # Add Tenant ID
New-ItemProperty -Path $HKLMregistryPath -Name 'KFMSilentOptInWithNotification' -Value '1' -PropertyType DWORD -Force | Out-Null ## Known File Redirection Notification Enable
if(!(Test-Path $HKLMregistryPath)){New-Item -Path $HKLMregistryPath -Force}


$env:USERPROFILE
$ODLocation = Get-ChildItem -path $env:USERPROFILE -Filter 'OneDrive - *'
Set-Location $ODLocation.Name
mkdir .\Downloads
mkdir .\Videos
