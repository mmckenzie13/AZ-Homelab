#description: Creates an NSG for a VM if none exists. Associates the vNIC. Adds rule to block Inbound SMB. 
#tags: DEC

<# Notes:
Creates an NSG for a VM if none exists. Associates the vNIC. Adds rule to block Inbound SMB. 
#>

# Connect to Azure
Connect-azaccount

try {
    # Get the VM and its current data disks
    $VM = Get-AzVM -Name $AzureVMName -ResourceGroupName $AzureResourceGroupName
    $RG = Get-Azresourcegroup -name $AzureResourceGroupName
    
    $NSGName = ($VM.name + "-nsg")

    # Remove NSG
    Remove-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $AzureResourceGroupName -force

    
    } # End of Try
catch {
    <#Do this if a terminating exception happens#>
}