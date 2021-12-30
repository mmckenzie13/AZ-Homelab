$vmName = Read-Host -Prompt "VM Name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"
$adminUsername = Read-Host -Prompt "Enter the administrator username"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$dnsLabelPrefix = Read-Host -Prompt "Enter an unique DNS name for the public IP (lowercase)"

New-AzResourceGroupDeployment `
    -ResourceGroupName "CORE-RG" `
    -TemplateUri "https://raw.githubusercontent.com/mmckenzie13/AZ-Homelab/main/DC-WS2019-Test.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix `
    -vmName $vmName `


