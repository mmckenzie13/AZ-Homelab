## This is for a Market Place Image Multi User that doesn't include Office, OneDrive, Teams, and FSLogix. 

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

## Download Files
# Source URL
$url = "https://mattmckenzie.co/setup/ODT-AVD.zip"
# Destation file
$dest = "c:\apps\ODT.zip"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
## Download Files
# Source URL
$url = "https://mattmckenzie.co/setup/ODT-AVDx32.zip"
# Destation file
$dest = "c:\apps\ODTx32.zip"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://aka.ms/fslogix/download"
# Destation file
mkdir C:\apps\FSlogix
$dest = "c:\apps\FSLogix\FSLogix.zip"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://go.microsoft.com/fwlink/?linkid=844652"
# Destation file
$dest = "c:\apps\OneDriveSetup.exe"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true"
# Destation file
$dest = "c:\apps\Teams.msi"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest


# Extract ODT & Install Office 365 x64
Expand-Archive -LiteralPath 'C:\apps\ODT.zip' -DestinationPath C:\ODT
Set-Location C:\odt\
.\run.bat

# Extract ODT & Install Office 365 x32 if needed
#Expand-Archive -LiteralPath 'C:\apps\ODT.zip' -DestinationPath C:\ODT
#Set-Location C:\odt\
#.\run.bat

# Enable Remote Desktop & Firewall Rule
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# FSLogix Install
Expand-Archive -LiteralPath 'C:\apps\fslogix\fslogix.zip' -DestinationPath C:\apps\fslogix\
Set-Location C:\apps\FSlogix\x64\Release
.\FSLogixAppsSetup.exe /quiet


# Timezone Redirection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableTimeZoneRedirection /t REG_DWORD /d 1 /f

# Disable Storage Sense
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f

# Enable Multi Session Win 10 Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f

# O365 Registry Changes
reg load HKU\TempDefault C:\Users\Default\NTUSER.DAT
reg add HKU\TempDefault\SOFTWARE\Policies\Microsoft\office\16.0\common /v InsiderSlabBehavior /t REG_DWORD /d 2 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v enable /t REG_DWORD /d 1 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v syncwindowsetting /t REG_DWORD /d 1 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSetting /t REG_DWORD /d 1 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSettingMonths  /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate /v hideupdatenotifications /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate /v hideenabledisableupdates /t REG_DWORD /d 1 /f

# OneDrive Setup
Set-Location C:\apps\
#.\OneDriveSetup.exe /uninstall
REG ADD "HKLM\Software\Microsoft\OneDrive" /v "AllUsersInstall" /t REG_DWORD /d 1 /reg:64
.\OneDriveSetup.exe /allusers
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe /background" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "SilentAccountConfig" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "KFMSilentOptIn" /t REG_SZ /d "<your-AzureAdTenantId>" /f

# Teams Install - Machine Install
msiexec /i C:\apps\Teams.msi /l*v C:\apps\Teams.log ALLUSER=1 ALLUSERS=1
reg add "HKLM\SOFTWARE\Microsoft\Teams" /v IsWVDEnvironment /t REG_DWORD /d 1 /f 
