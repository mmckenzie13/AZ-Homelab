## Run from Cloud Shell for Quick Access

## Build Core Resource Group
$ClientPF = "MIT"
$Location = "East US"
$RG = $ClientPF + "-Core-RG"
$Tags = @{Empty=$null; Department="Operations"; Type="VM"}
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

## Build Core VNET
$VNETPrefix = "10.100.0.0/16"
$CoreVNETName = $ClientPF + "-Core-VNET"
New-AzVirtualNetwork -Name $CoreVNETName ResourceGroupName = $RG Location = $Location AddressPrefix = $VNETPrefix

## Core VNET Subnets
$VSubnetPrimary = "Main"
$VSubnetGateway = "Gateway"
az network vnet subnet create -n $VSubnetPrimary --vnet-name $CoreVNETName -g $RG --address-prefixes "10.100.0.0/24"
az network vnet subnet create -n $VSubnetGateway --vnet-name $CoreVNETName -g $RG --address-prefixes "10.100.3.0/27"

## Build vFortigate VNET
$vFVNETPrefix = "10.0.0.0/16"
$vFCoreVNETName = $ClientPF + "-VF-VNET"
New-AzVirtualNetwork -Name $vFCoreVNETName ResourceGroupName = $RG Location = $Location AddressPrefix = $vFVNETPrefix

## vFortigate VNET Subnets
$vFVSubnetExternal = "External"
$vFVSubnetProtected = "Protected"
$vFVSubnetInternal = "Internal"
az network vnet subnet create -n $vFVSubnetExternal --vnet-name $vFCoreVNETName -g $RG --address-prefixes "10.0.0.0/26"
az network vnet subnet create -n $vFVSubnetProtected --vnet-name $vFCoreVNETName -g $RG --address-prefixes "10.0.2.0/24"
az network vnet subnet create -n $vFVSubnetInternal --vnet-name $vFCoreVNETName -g $RG --address-prefixes "10.0.1.0/26"

