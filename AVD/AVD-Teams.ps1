# Exclusively Teams for Install / Update

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

# Clear existing Files under C:\Apps if it exists
get-childitem C:\apps\* -Recurse | Remove-item -Confirm:$false -Recurse

## Download Files
# Source URL
$url = "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true"
# Destation file
$dest = "c:\apps\Teams.msi"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest

# Teams Install - Machine Install - Uninstall Previous, Reinstall Latest
msiexec /passive /x C:\apps\Teams.msi /l*v C:\apps\Teams.log
Start-Sleep -Seconds 30
msiexec /i C:\apps\Teams.msi /l*v C:\apps\Teams.log ALLUSER=1 ALLUSERS=1