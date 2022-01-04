# Set the Time Zone
Set-TimeZone -Name "Central Standard Time"

# Install the Roles
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature -name DNS -IncludeManagementTools
Install-WindowsFeature -name DHCP -IncludeManagementTools
