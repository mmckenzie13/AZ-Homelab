# Exclusively OneDrive for Install / Update

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

# Clear existing Files under C:\Apps if it exists
get-childitem C:\apps\* -Recurse | Remove-item -Confirm:$false -Recurse

## Download Files

# Source URL
$url = "https://go.microsoft.com/fwlink/?linkid=844652"
# Destation file
$dest = "c:\apps\OneDriveSetup.exe"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest

# OneDrive Setup - Uninstall Previous, Reinstall Latest
Set-Location C:\apps\
.\OneDriveSetup.exe /uninstall
Start-Sleep -Seconds 15
.\OneDriveSetup.exe /allusers