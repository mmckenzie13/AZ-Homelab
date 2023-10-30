#description: Deletes associated NSG for AVD Session Host. To be used at decomm / reimage.
#tags: BIT

<# Notes:
Deletes associated NSG for AVD Session Host. To be used at decomm / reimage.
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
