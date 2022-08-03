## Make / Set Working Directory
mkdir C:\apps
Set-Location C:\apps\

## Download Updated Files

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

# FSLogix Registry - Uncomment if patch needed. Not updated often. 
#.\FSLogixAppsSetup.exe /quiet

# OneDrive Setup - Uninstall Previous, Reinstall Latest
Set-Location C:\apps\
.\OneDriveSetup.exe /uninstall
REG ADD "HKLM\Software\Microsoft\OneDrive" /v "AllUsersInstall" /t REG_DWORD /d 1 /reg:64
.\OneDriveSetup.exe /allusers

# Teams Install - Machine Install - Uninstall Previous, Reinstall Latest
msiexec /passive /x C:\apps\Teams.msi /l*v C:\apps\Teams.log
msiexec /i C:\apps\Teams.msi /l*v C:\apps\Teams.log ALLUSER=1 ALLUSERS=1
reg add "HKLM\SOFTWARE\Microsoft\Teams" /v IsWVDEnvironment /t REG_DWORD /d 1 /f 

