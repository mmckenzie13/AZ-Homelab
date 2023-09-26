#description: Set NSG to block SMB
#tags: Nerdio, Preview



# Connect to Azure
connect-azAccount

# Variables
$subscriptionID = $AzureSubscriptionId
$rgname = $AzureResourceGroupName
$vmname = $AzureVMName

#Log in to your subscription
Set-AzContext -Subscription $subscriptionID

# Check if VM is already in correct AZ
$GetVMinfo = Get-AzVM -ResourceGroupName $rgname -Name $vmName

# Get NSG if it exists
Get-AzNetworkSecurityGroup | format-table Name, Location, ResourceGroupName, ProvisioningState, ResourceGuid

# Create NSG if one doesn't exist
New-AzNetworkSecurityGroup -Name myNSG -ResourceGroupName myResourceGroup  -Location  eastus

# Create security rules
## Place the network security group configuration into a variable. ##
$networkSecurityGroup = Get-AzNetworkSecurityGroup -Name myNSG -ResourceGroupName myResourceGroup
## Create the security rule. ##
Add-AzNetworkSecurityRuleConfig -Name RDP-rule -NetworkSecurityGroup $networkSecurityGroup `
-Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 300 `
-SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
## Updates the network security group. ##
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $networkSecurityGroup