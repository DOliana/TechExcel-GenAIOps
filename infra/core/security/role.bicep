metadata description = 'Creates a role assignment for a service principal.'
param principalId string

@allowed([
  'Device'
  'ForeignGroup'
  'Group'
  'ServicePrincipal'
  'User'
])
param principalType string = 'ServicePrincipal'
param roleDefinitionId string

resource existingRole 'Microsoft.Authorization/roleAssignments@2022-04-01' existing = {
  name: guid(subscription().id, resourceGroup().id, principalId, roleDefinitionId)
}

resource role 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (existingRole == null) {
  name: guid(subscription().id, resourceGroup().id, principalId, roleDefinitionId)
  properties: {
    principalId: principalId
    principalType: principalType
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
  }
}
