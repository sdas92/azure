#Generates a CSV list with all subscriptions' list and their name...
#Author: Somnath Das
az login | Out-Null
$subscriptions = az account list --all | ConvertFrom-Json

$outputPath = "\\Somnath-Das\e$\logs\az.csv"
$allsubList = @()

foreach($sub in $subscriptions) {
  $objSubs = New-Object psobject
  $objSubs | Add-Member -MemberType NoteProperty -Name "SubscriptionID" -Value $sub.id
  $objSubs | Add-Member -MemberType NoteProperty -Name "SubscriptionName" -Value $sub.name
  $objSubs | Add-Member -MemberType NoteProperty -Name "Check" -Value "Y"
  $allsubList += $objSubs
  $objSubs = $null
}

$allsubList | Export-Csv -Path  $outputPath -NoTypeInformation
