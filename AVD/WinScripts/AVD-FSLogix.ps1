# Exclusively FSLogix for Install / Update

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

# Clear existing Files under C:\Apps if it exists
get-childitem C:\apps\fslogix\* -Recurse | Remove-item -Confirm:$false -Recurse

## Download Files

# Source URL
$url = "https://aka.ms/fslogix/download"
# Destation file
mkdir C:\apps\FSlogix
$dest = "c:\apps\FSLogix\FSLogix.zip"
# Download the file
Start-BitsTransfer -Source $url -Destination $dest 
# Invoke-WebRequest -Uri $url -OutFile $dest # Slower Method

# FSLogix Install (Not Updated Often, uncomment to update, will restart the session host.)
Expand-Archive -LiteralPath 'C:\apps\fslogix\fslogix.zip' -DestinationPath C:\apps\fslogix\
Set-Location C:\apps\fslogix\
$fslogix = get-childitem | ?{ $_.PSIsContainer }
$fslogix = "C:\apps\fslogix\" + $fslogix.name + "\x64\Release"
Set-Location $fslogix
.\FSLogixAppsSetup.exe /quiet

Start-Sleep -Seconds 180
