targetScope = 'subscription'

param principalId string = '69615b5e-8b26-430c-ae89-4e626f5ba240'

@description('The resource name')
@minLength(3)
param name string = 'swetuggdemosastack'

param subscriptionId string = '82715c44-513a-4b5f-95d9-d95bad8351d6'
param resourceGroupName string = 'Swetugg'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  scope: subscription(subscriptionId)
  name: resourceGroupName
}

module storageStack 'storageStack1.bicep' = {
  name: 'storageStack1'
  scope: resourceGroup
  params: {
    principalId: principalId
    name: name
  }
}
