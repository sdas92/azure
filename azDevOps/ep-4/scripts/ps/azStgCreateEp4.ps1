# Variable section
$rgName = "daslearning-rg-ep4"
$location = "Central US"
$storageAcNames = @("daslearning01", "daslearning02", "daslearning03")
$containerNames = @("azdvopsep1", "azdvopsep2", "azdvopsep3")

# Create Resource Group
New-AzResourceGroup -Name $rgName -Location $location

$i = 0
foreach($stAcName in $storageAcNames){
    # Create Storage Account
    New-AzStorageAccount -ResourceGroupName $rgName -Name $stAcName -Location $location -SkuName "Standard_LRS"

    # Get the storage context
    $stAcc = Get-AzStorageAccount -ResourceGroupName $rgName -Name $stAcName
    $ctx = $stAcc.Context

    #Create a new container
    New-AzStorageContainer -Name $containerNames[$i] -Context $ctx
    $i = $i + 1
}

$randomPosition = Get-Random -InputObject @(0, 1, 2)
$selectStorage = $storageAcNames[$randomPosition]
$selectContainer = $containerNames[$randomPosition]

#Set pipeline run time varible to be accessible from other tasks & jobs
Write-Output "##vso[task.setvariable variable=uploadAccount;isOutput=true]$selectStorage"
Write-Output "##vso[task.setvariable variable=uploadContainer;isOutput=true]$selectContainer"
Write-Output "##vso[task.setvariable variable=rgName;isOutput=true]$rgName"

