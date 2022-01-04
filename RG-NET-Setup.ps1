## Run from Cloud Shell for Quick Access
# Build out Resource Groups (RGs)
$Location = "East US"
$RG = "CORE-RG"
$Tags = @{Empty=$null; Department="Operations"; Type="VNET"}
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "NET-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "STORE-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "BACKUP-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "DB-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "VDI-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "APPS-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "WEB-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

$RG = "DEV-RG"
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

## Build Core VNET & Core VNET Subnets
$Location = "East US"
$RG = "NET-RG"
$MAINSN = New-AzVirtualNetworkSubnetConfig -Name MainSubnet -AddressPrefix "10.100.0.0/24"
$VNGSN  = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet  -AddressPrefix "10.100.3.0/27"
New-AzVirtualNetwork -Name "CORE-VNET" -ResourceGroupName $RG -Location $Location -AddressPrefix "10.100.0.0/22" -Subnet $MAINSN,$VNGSN

## Build vFortigate VNET & Subnets
$Location = "East US"
$RG = "NET-RG"
$vFSSNExternal = New-AzVirtualNetworkSubnetConfig -Name External -AddressPrefix "10.0.0.0/26"
$vFSSNProtected = New-AzVirtualNetworkSubnetConfig -Name Protected -AddressPrefix "10.0.2.0/24"
$vFSSNInternal = New-AzVirtualNetworkSubnetConfig -Name Internal -AddressPrefix "10.0.1.0/24"
New-AzVirtualNetwork -Name "vFortigate-VNET" -ResourceGroupName $RG -Location $Location -AddressPrefix "10.0.0.0/22" -Subnet $vFSSNExternal, $vFSSNProtected, $vFSSNInternal