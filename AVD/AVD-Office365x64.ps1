## This is for installing Office 365 x64. 

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

## Download Files
# Source URL
$url = "https://github.com/mmckenzie13/AZ-Homelab/blob/main/Packages/ODT-AVD.zip"
# Destation file
$dest = "c:\apps\ODT.zip"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest

# Extract ODT & Install Office 365 x64
Expand-Archive -LiteralPath 'C:\apps\ODT.zip' -DestinationPath C:\ODT
Set-Location C:\odt\
.\run.bat