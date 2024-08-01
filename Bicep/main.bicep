targetScope='subscription'

param resourceGroupUKSParam object
param tagsParam object = {}
param vnetParam object
param keyVaultParam object
param vmParam object

var serviceName = 'selfhostedagent'

module resourceGroupUKS 'Modules/resource-group.bicep' = {
  name: '${serviceName}-resourceGroup'
  params: {
    resourceGroup: resourceGroupUKSParam
    tags: tagsParam
  }
}

module virtualNetwork 'Modules/virtual-network.bicep' = {
  name: '${serviceName}-virtualNetwork'
  scope: resourceGroup(resourceGroupUKSParam.name)
  params: {
    vnet: vnetParam
    tags: tagsParam
    location: resourceGroupUKSParam.location
  }
}

module keyVault 'Modules/key-vault.bicep' = {
  name: '${serviceName}-keyVault'
  scope: resourceGroup(resourceGroupUKSParam.name)
  params: {
    keyVault: keyVaultParam
    tags: tagsParam
    location: resourceGroupUKSParam.location
  }
}

module virtualMachine 'Modules/virtual-machine.bicep' = {
  name: '${serviceName}-virtualMachine'
  scope: resourceGroup(resourceGroupUKSParam.name)
  params: {
    tags: tagsParam
    location: resourceGroupUKSParam.location
    vm: vmParam
    subnetId: virtualNetwork.outputs.subnetId
    sshKeyUri:keyVault.outputs.sshKeyUri
  }
  dependsOn: [
    virtualNetwork
  ]
}

output keyVaultId string = keyVault.outputs.keyVaultId
output vnetdefaultsubnetId string = virtualNetwork.outputs.subnetId
output sshKeyUri string = keyVault.outputs.sshKeyUri

