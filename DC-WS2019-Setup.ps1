## Create the Availability Set for the 2 DCs
New-AzAvailabilitySet -ResourceGroupName "CORE-RG" -Name "DC-AS" -Location "East US" -PlatformFaultDomainCount 2 -PlatformUpdateDomainCount 5 -Sku Aligned

## Create DC01
## Download Files

# Source URL
$url = "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/DC-WS2019-Template.json"
# Destation file
$dest = ".\DC-WS2019-Template.json"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/ParameterFiles/DC01.json"
# Destation file
$dest = ".\DC01.json"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Source URL
$url = "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/ParameterFiles/DC02.json"
# Destation file
$dest = ".\DC02.json"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest

# Variable Inputs
$adminUsername = Read-Host -Prompt "Enter the local administrator username"
$adminPassword = Read-Host -Prompt "Enter the local administrator password" -AsSecureString

# Have to clean up the variable before use
$vnetId = get-azvirtualnetwork -name CORE-VNET | grep Id | head -1
$vnetId = $vnetId.TrimStart("Id")
$vnetId = $vnetId.Trim()
$vnetId = $vnetId.TrimStart(": ")

# Deployment after variables and inputs. Referencing the template files downloaded from Github Repo
New-AzResourceGroupDeployment `
    -Name DC01 `
    -ResourceGroupName CORE-RG `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -virtualNetworkId $vnetId `
    -TemplateFile ".\DC-WS2019-Template.json" `
    -TemplateParameterFile ".\DC01.json"

## Create DC02 with the same credentials
New-AzResourceGroupDeployment `
    -Name DC01 `
    -ResourceGroupName CORE-RG `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -virtualNetworkId $vnetId `
    -TemplateFile ".\DC-WS2019-Template.json" `
    -TemplateParameterFile ".\DC02.json"