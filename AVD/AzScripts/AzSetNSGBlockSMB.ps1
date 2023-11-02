#description: Set NSG to block SMB
#tags: Github, BIT



# Connect to Azure
connect-azAccount

try {
    # Get the VM and its current data disks
    $VM = Get-AzVM -Name $AzureVMName -ResourceGroupName $AzureResourceGroupName
    $RG = Get-Azresourcegroup -name $AzureResourceGroupName
    $Region = $RG.Location
    $Tags = get-aztag -resourceid $VM.id
    $Tags = $Tags.properties.TagsProperty


    # Query for NIC attached to VM, pass into $NIC
    $NIC =  Get-AzNetworkInterface -resourceID $VM.NetworkProfile.NetworkInterfaces.Id

    # Detect if VM already has NSG for vNIC
    
    if($NIC.networksecuritygrouptext -eq $null)
    {
        Write-Output "INFO: This VM already has an NSG. No action needed, stopping script."
    }
    if($NIC.networksecuritygrouptext -ne $null) 
    {
        <# Create a new NSG #>
        $NSGName = ($VM.name + "-nsg") 
        New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $AzureResourceGroupName -Location $Region -Tag $Tags
        # Assign new NSG to VM NIC
        # $nic = Get-AzNetworkInterface -ResourceGroupName "ResourceGroup1" -Name "NetworkInterface1"
        $nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $AzureResourceGroupName -Name $NSGName
        $nic.NetworkSecurityGroup = $nsg
        $nic | Set-AzNetworkInterface
        # Add NSG Rule
        $port=445
        $rulename="IB-SMB-Block"
        # Get the NSG resource
        $nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $AzureResourceGroupName
        # Add the inbound security rule.
        $nsg | Add-AzNetworkSecurityRuleConfig -Name $rulename -Description "Block Inbound SMB" -Access Deny `
        -Protocol * -Direction Inbound -Priority 200 -SourceAddressPrefix "*" -SourcePortRange * `
        -DestinationAddressPrefix * -DestinationPortRange $port
        # Update the NSG.
        $nsg | Set-AzNetworkSecurityGroup

    }
    } # End of Try
catch {
    <#Do this if a terminating exception happens#>
}
