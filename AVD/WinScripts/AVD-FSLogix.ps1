# Exclusively FSLogix for Install / Update

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

# Clear existing Files under C:\Apps if it exists
get-childitem C:\apps\* -Recurse | Remove-item -Confirm:$false -Recurse

## Download Files

# Source URL
$url = "https://aka.ms/fslogix/download"
# Destation file
mkdir C:\apps\FSlogix
$dest = "c:\apps\FSLogix\FSLogix.zip"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest

# FSLogix Install (Not Updated Often, uncomment to update, will restart the session host.)
Expand-Archive -LiteralPath 'C:\apps\fslogix\fslogix.zip' -DestinationPath C:\apps\fslogix\
Set-Location C:\apps\FSlogix\x64\Release
.\FSLogixAppsSetup.exe /quiet

Start-Sleep -Seconds 180