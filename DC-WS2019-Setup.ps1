## Create the Availability Set for the 2 DCs
New-AzAvailabilitySet -ResourceGroupName "CORE-RG" -Name "DC-AS" -Location "East US" -PlatformFaultDomainCount 2 -PlatformUpdateDomainCount 5 -Sku Aligned

## Create DC01
$adminUsername = Read-Host -Prompt "Enter the local administrator username"
$adminPassword = Read-Host -Prompt "Enter the local administrator password" -AsSecureString

New-AzResourceGroupDeployment `
    -ResourceGroupName "CORE-RG" `
    -TemplateUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/DC-WS2019-Template.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix `
    -vmName DC01

## Create DC02
$adminUsername = Read-Host -Prompt "Enter the local administrator username"
$adminPassword = Read-Host -Prompt "Enter the local administrator password" -AsSecureString

New-AzResourceGroupDeployment `
    -ResourceGroupName "CORE-RG" `
    -TemplateUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/DC-WS2019-Template.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix `
    -vmName DC01
