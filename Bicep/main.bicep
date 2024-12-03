targetScope='subscription'

param resourceGroupEUSParam object
param tagsParam object
param vnetParam object
param vmParam object
param deploySSHParam bool = false

param deploymentNameParam string  = 'agentpool'

module resourceGroupEUS 'modules/resource-group.bicep' = {
  name: '${deploymentNameParam}-resourceGroup'
  params: {
    resourceGroup: resourceGroupEUSParam
    tags: tagsParam
  }
}

module virtualNetwork 'modules/virtual-network.bicep' = {
  name: '${deploymentNameParam}-virtual-network'
  scope: resourceGroup(resourceGroupEUSParam.name)
  params: {
    vnet: vnetParam
    location: resourceGroupEUSParam.location
    tags: tagsParam
    deploySSH: deploySSHParam
  }
  dependsOn: [
    resourceGroupEUS
  ]
}

module virtualMachine 'modules/virtual-machine.bicep' = {
  name: '${deploymentNameParam}-virtual-machine'
  scope: resourceGroup(resourceGroupEUSParam.name)
  params: {
    vm: vmParam
    location: resourceGroupEUSParam.location
    tags: tagsParam
    subnetId: virtualNetwork.outputs.subnetId
    networkSecurityGroupId: virtualNetwork.outputs.networkSecurityGroupId
  }
  dependsOn: [
    virtualNetwork
  ]
}

module roleAssignment 'modules/role-assignment.bicep' = {
  name: '${deploymentNameParam}-role-assignment'
  scope: resourceGroup(resourceGroupEUSParam.name)
  params: {
    vmManagedIdentityPrincipalId: virtualMachine.outputs.vmManagedIdentityPrincipalId
  }
} 

output subnetId string = virtualNetwork.outputs.subnetId
output networkSecurityGroupId string = virtualNetwork.outputs.networkSecurityGroupId
output vmManagedIdentityPrincipalId string = virtualMachine.outputs.vmManagedIdentityPrincipalId
