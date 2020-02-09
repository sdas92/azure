#Tags all resource groups and resources under a given subscription...

az login

#Global variables
$subscriptionID = "Your_subscription_ID"
$tagApp = "AppName"
$tagCountry = "India"


#Tag all resource groups.
Function tagResourceGroups
{
  param([string]$RG)
  az group update --resource-group $RG --tags Application=$tagApp Country=$tagCountry
}

#Tag all resources under a RG.
Function tagResources
{
  param([string]$Resource)
  az resource tag --tags Application=$tagApp Country=$tagCountry --ids $Resource
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
