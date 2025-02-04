Push-Location -Path '/Users/simon/Documents/github/SwetuggStockholm2025-Stacks/'

Connect-AzAccount -Tenant 'simonw.se' -Subscription 'Experiments'

New-AzResourceGroupDeployment -TemplateFile './storageStack1.bicep' -ResourceGroupName 'Swetugg' -Name 'regularDeployment0'

New-AzResourceGroupDeployment -TemplateFile './storageStack2.bicep' -ResourceGroupName 'Swetugg' -Name 'regularDeployment1'


$ParamFromFile = Get-Content './storageStack.stack.json' -Raw | ConvertFrom-Json -AsHashtable
($Stack = New-AzResourceGroupDeploymentStack -TemplateFile './storageStack1.bicep' -ResourceGroupName 'Swetugg' -Name 'SwetuggStorageStack' @ParamFromFile)
($Stack = New-AzResourceGroupDeploymentStack -TemplateFile './storageStack2.bicep' -ResourceGroupName 'Swetugg' -Name 'SwetuggStorageStack' @ParamFromFile)
($Stack = New-AzResourceGroupDeploymentStack -TemplateFile './empty.bicep' -ResourceGroupName 'Swetugg' -Name 'SwetuggStorageStack' @ParamFromFile)

# $StackId = '/subscriptions/82715c44-513a-4b5f-95d9-d95bad8351d6/resourceGroups/Swetugg/providers/Microsoft.Resources/deploymentStacks/SwetuggStorageStack'
Remove-AzResourceGroupDeploymentStack -ResourceId $Stack.Id -BypassStackOutOfSyncError -Force -ActionOnUnmanage DeleteAll

Pop-Location