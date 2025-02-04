param principalId string = '69615b5e-8b26-430c-ae89-4e626f5ba240'

@description('The resource name')
@minLength(3)
param name string = 'swetuggdemosastack'

resource swetuggdemostorage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: 'swedencentral'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: true
    minimumTlsVersion: 'TLS1_2'
    allowSharedKeyAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: swetuggdemostorage
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: 'mandatoryfolder'
  parent: blobservice
}

var blobDataOwnerRoleId = 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
resource blobDataOwnerRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: blobDataOwnerRoleId
}
resource blobDataOwnerAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, blobDataOwnerRole.id, resourceGroup().id)
  scope: swetuggdemostorage
  properties: {
    principalId: principalId
    roleDefinitionId: blobDataOwnerRole.id
  }
}
