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
# Source URL
$url = "https://mattmckenzie.co/setup/ninite.exe"
# Destation file
$dest = "c:\apps\ninite.exe"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://mattmckenzie.co/setup/FortiClient.exe"
# Destation file
$dest = "c:\apps\forticlient.exe"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://aka.ms/fslogix/download"
# Destation file
mkdir C:\apps\FSlogix
$dest = "c:\apps\FSLogix\FSLogix.zip"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest


# Extract ODT & Install Office 365
Expand-Archive -LiteralPath 'C:\apps\ODT.zip' -DestinationPath C:\ODT
Set-Location C:\odt\
.\run.bat

# Run Ninite for Apps
Set-Location C:\apps\
.\ninite.exe

# Enable Remote Desktop & Firewall Rule
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Install Forticlient VPN Software
.\forticlient.exe /quiet /log"Log.txt"

# FSLogix Registry
Expand-Archive -LiteralPath 'C:\apps\fslogix\fslogix.zip' -DestinationPath C:\apps\fslogix\
Set-Location C:\apps\FSlogix\x64\Release
.\FSLogixAppsSetup.exe /quiet
$newValue = New-ItemProperty -Path "HKLM:\SOFTWARE\ContosoCompany\" -Name 'HereString' -PropertyType MultiString -Value @"
This is text which contains newlines
It can also contain "quoted" strings
"@
$newValue.multistring