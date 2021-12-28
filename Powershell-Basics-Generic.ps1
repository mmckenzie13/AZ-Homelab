## Run from Cloud Shell for Quick Access

## Build Core-RG Resource Group
$Location = "East US"
$RG = "Core-RG"
$Tags = @{Empty=$null; Department="Operations"; Type="VM"}
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

## Build Core VNET & Core VNET Subnets
$RG = "Core-RG"
$MAINSN = New-AzVirtualNetworkSubnetConfig -Name MainSubNet -AddressPrefix "10.100.0.0/24"
$VNGSN  = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet  -AddressPrefix "10.100.3.0/27"
New-AzVirtualNetwork -Name "Core-VNET" -ResourceGroupName $RG -Location $Location -AddressPrefix "10.100.0.0/16" -Subnet $MAINSN,$VNGSN

## Build vFortigate VNET & Subnets
$vFSSNExternal = New-AzVirtualNetworkSubnetConfig -Name External -AddressPrefix "10.0.0.0/26"
$vFSSNProtected = New-AzVirtualNetworkSubnetConfig -Name Protected -AddressPrefix "10.0.2.0/24"
$vFSSNInternal = New-AzVirtualNetworkSubnetConfig -Name Internal -AddressPrefix "10.0.1.0/24"
New-AzVirtualNetwork -Name "vFortigate-VNET" -ResourceGroupName $RG -Location $Location -AddressPrefix "10.0.0.0/16" -Subnet $vFSSNExternal, $vFSSNProtected, $vFSSNInternal

## Build OPS-RG Resource Group
$Location = "East US"
$RG = "OPS-RG"
$Tags = @{Empty=$null; Department="Operations"; Type="VM"}
New-AzResourceGroup -Name $RG -Location $Location -Tag $Tags

## Build Availability Set for OPS-RG VMs - DCs, FP
$AS = "OPS-AS"
$Location = "East US"
$availSet = Get-AzAvailabilitySet `
-ResourceGroupName $RG `
-Name $AS `
-ErrorAction Ignore
if (-Not $availSet) {
$availSet = New-AzAvailabilitySet `
-Location $Location `
-Name $AS `
-ResourceGroupName $RG `
-PlatformFaultDomainCount 2 `
-PlatformUpdateDomainCount 3 `
-Sku Aligned
}
## Build OPS-RG VMs - DCs, FP Configs
$ClientPF = "MIT"
$vmDC01 = New-AzVMConfig -VMName $ClientPF + "-DC01" -VMSize "Standard_BMs1" -AvailabilitySetID $AS.Id -LicenseType "Windows_Server"


## Build OPS-RG VMs - DCs, FP
New-AzVm `
    -ResourceGroupName $RG `
    -Name $ClientPF + "-DC01" `
    -Location $Location `
    -VirtualNetworkName "Core-VNET" `
    -SubnetName "MainSubNet" `
    -SecurityGroupName "DC01-SG" `
    -PublicIpAddressName "DC01-Pub" `
    -OpenPorts 3389

## Build OPS-RG VMs - DCs, FP

$ClientPF = "MIT"
$VMLocalAdminUser = "pcadmin"
$VMLocalAdminSecurePassword = ConvertTo-SecureString "##Power2021##" -AsPlainText -Force
$LocationName = "eastus"
$ResourceGroupName = "OPS-RG"
$ComputerName = $ClientPF + "-DC01"
$VMName = $ClientPF + "-DC01"
$VMSize = "Standard_B2ms"

$NICName = $ClientPF + "NIC01"

$NIC = New-AzNetworkInterface -Name $NICName -ResourceGroupName $ResourceGroupName -Location $LocationName -SubnetId $Vnet.Subnets[0].Id

$Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);

$VirtualMachine = New-AzVMConfig -VMName $VMName -VMSize $VMSize
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $ComputerName -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2019-Datacenter' -Version latest

New-AzVM -ResourceGroupName $ResourceGroupName -Location $LocationName -VM $VirtualMachine -Verbose