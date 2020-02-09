#Tags all resource groups and resources under a given subscription...
#Author: Somnath Das
az login | Out-Null

#Global variables
$subscriptionID = "Your_subscription_ID"
$tagApp = "Learning App"
$tagBrand = "DasLearning"
$tagDivision = "IT"
$tagCountry = "India"
$tagRegion = "APAC"
$tagEnvironment = "DEV"
$tagService = "Monitoring"


#Tag all resource groups.
Function tagResourceGroups
{
  param([string]$RG)
  az group update --resource-group $RG --tags Application=$tagApp Brand=$tagBrand Division=$tagDivision Country=$tagCountry Region=$tagRegion Environment=$tagEnvironment Service=$tagService
}

#Tag all resources under a RG.
Function tagResources
{
  param([string]$Resource)
  az resource tag --ids $Resource --tags Application=$tagApp Brand=$tagBrand Division=$tagDivision Country=$tagCountry Region=$tagRegion Environment=$tagEnvironment Service=$tagService
}

#Get all resource groups and tag everything..
$allresourceGroups = az group list --subscription $subscriptionID | ConvertFrom-Json
foreach($resourceGroup in $allresourceGroups)
{
  $rgName = $resourceGroup.name
  tagResourceGroups -RG $rgName
  $allResources = az resource list --resource-group $rgName | ConvertFrom-Json
  foreach($resource in $allResources)
  {
    $resourceID = $resource.id
    tagResources -Resource $resourceID
  }
}
