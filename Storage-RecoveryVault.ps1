## Create the Storage Account

$resourceGroupName = "STORE-RG"
$storageAccountName = "CORE-STORE$(Get-Random)"
$region = "eastus"

# https://docs.microsoft.com/en-us/rest/api/storagerp/srp_sku_types
$storAcct = New-AzStorageAccount `
    -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName `
    -SkuName Standard_GRS `
    -Location $region `
    -Kind StorageV2

# Create a File Share
# Assuming $resourceGroupName and $storageAccountName from earlier in this document have already
# been populated. The access tier parameter may be TransactionOptimized, Hot, or Cool for GPv2 
# storage accounts. Standard tiers are only available in standard storage accounts. 
$shareName = "cloudshell"

New-AzRmStorageShare `
        -ResourceGroupName $resourceGroupName `
        -StorageAccountName $storageAccountName `
        -Name $shareName `
        -AccessTier TransactionOptimized `
        -QuotaGiB 50 | `
    Out-Null


## Create the Recovery Services Vault
$resourceGroupName = "BACKUP-RG"
$region = "eastus"