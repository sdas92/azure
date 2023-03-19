# Variable section
$rgName = "daslearning-rg-01"
$location = "Central US"
$storageAcName = "daslearningdevopsep2"
$containerName = "azdvopsep2"

# Create Resource Group
New-AzResourceGroup -Name $rgName -Location $location

# Create Storage Account
New-AzStorageAccount -ResourceGroupName $rgName -Name $storageAcName -Location $location -SkuName "Standard_LRS"

# Get the storage context
$stAcc = Get-AzStorageAccount -ResourceGroupName $rgName -Name $storageAcName
$ctx = $stAcc.Context

#Create a new container
New-AzStorageContainer -Name $containerName -Context $ctx

# Upload a file to the storage container
Set-AzStorageBlobContent -File ./dataFiles/ep2.txt -Blob "ep2.txt" -Context $ctx -Container $containerName
