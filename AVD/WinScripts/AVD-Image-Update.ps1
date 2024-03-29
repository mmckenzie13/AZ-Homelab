## Make / Set Working Directory
mkdir C:\apps
Set-Location C:\apps\

# Clear existing Files under C:\Apps
get-childitem C:\apps\* -Recurse | Remove-item -Confirm:$false -Recurse

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

# OneDrive Setup - Uninstall Previous, Reinstall Latest
Set-Location C:\apps\
.\OneDriveSetup.exe /uninstall
Start-Sleep -Seconds 15
.\OneDriveSetup.exe /allusers

# Teams Install - Machine Install - Uninstall Previous, Reinstall Latest
msiexec /passive /x C:\apps\Teams.msi /l*v C:\apps\Teams.log
Start-Sleep -Seconds 30
msiexec /i C:\apps\Teams.msi /l*v C:\apps\Teams.log ALLUSER=1 ALLUSERS=1

Start-Sleep -Seconds 60
# FSLogix Install (Not Updated Often, uncomment to update, will restart the session host.)
Expand-Archive -LiteralPath 'C:\apps\fslogix\fslogix.zip' -DestinationPath C:\apps\fslogix\
Set-Location C:\apps\FSlogix\x64\Release
#.\FSLogixAppsSetup.exe /quiet
