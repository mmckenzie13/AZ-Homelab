# Setup Working Directory
mkdir C:\apps
Set-Location C:\apps\

# Set the Time Zone
Set-TimeZone -Name "Central Standard Time"

# Install the Roles
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools #AD Role
Install-WindowsFeature -name DNS -IncludeManagementTools #DNS Role
Install-WindowsFeature -name DHCP -IncludeManagementTools #DHCP
Install-WindowsFeature -name FS-DFS-Namespace -IncludeManagementTools #DFS
Install-WindowsFeature NPAS -IncludeManagementTools #NPS Role / RADIUS

## Azure AD Connect
# Source URL
$url = "https://www.microsoft.com/en-us/download/confirmation.aspx?id=47594"
# Destation file
$dest = "c:\apps\AzureADConnect.msi"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest

# Azure MFA for NPS - https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-nps-extension

# Setup New Forest / New Domain
# Install-ADDSForest -installdns -DomainName corp.contoso.com -DomainNetbiosName corp -DatabasePath "C:\Windows\NTDS" -SYSVOLPath "C:\Windows\SYSVOL" -LogPath "C:\Logs"

# Setup Additional Domain Controller, Don't Forget DNS
# Install-ADDSDomainController -InstallDns -Credential (Get-Credential "CORP\Administrator") -DomainName "corp.contoso.com" -DatabasePath "C:\Windows\NTDS" -SYSVOLPath "C:\Windows\SYSVOL" -LogPath "C:\Logs"

# AD Replication
repadmin /replsummary
repadmin /showrepl
repadmin /showrepl /errorsonly
dcdiag > C:\dcdiag.txt

# AD Replication Status Tool - https://www.microsoft.com/en-us/download/details.aspx?id=30005

# Check FSMO Roles Holder
Netdom query FSMO
# or...
Import-Module activedirectory
$ADDomain = (get-addomain).Forest
Get-ADForest $ADDomain| ft DomainNamingMaster, SchemaMaster
Get-ADDomain $ADDomain | ft InfrastructureMaster, PDCEmulator, RIDMaster

# Enable Recycle Bin for 60 days
$ADForest = (get-addomain).Forest
$ADDomain = (get-addomain).DistinguishedName
$ADIdentity = ("CN=Configuration," + $ADDomain)
$ADRecycle = ("CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services," + $ADIdentity)
Enable-ADOptionalFeature –Identity $ADRecycle –Scope ForestOrConfigurationSet –Target $ADForest

# Transfer FSMO Roles
# Import-Module activedirectory
# Move-ADDirectoryServerOperationMasterRole -Identity “dc2” –OperationMasterRole DomainNamingMaster,PDCEmulator,RIDMaster,SchemaMaster,InfrastructureMaster

