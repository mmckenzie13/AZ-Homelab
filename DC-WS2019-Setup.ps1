## Create the Availability Set for the 2 DCs
New-AzAvailabilitySet -ResourceGroupName "CORE-RG" -Name "DC-AS" -Location "East US" -PlatformFaultDomainCount 2 -PlatformUpdateDomainCount 5 -Sku Aligned

## Create DC01
$adminUsername = Read-Host -Prompt "Enter the local administrator username"
$adminPassword = Read-Host -Prompt "Enter the local administrator password" -AsSecureString

New-AzResourceGroupDeployment `
    -Name DC01 `
    -ResourceGroupName CORE-RG `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -VirtualNetworkID "CORE-VNET" `
    -TemplateUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/DC-WS2019-Template.json" `
    -TemplateParameterUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/ParameterFiles/DC01.json" 


## Create DC02
$adminUsername = Read-Host -Prompt "Enter the local administrator username"
$adminPassword = Read-Host -Prompt "Enter the local administrator password" -AsSecureString

New-AzResourceGroupDeployment `
    
    -TemplateUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/DC-WS2019-Template.json" `
    -TemplateParameterUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/ParameterFiles/DC02.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
