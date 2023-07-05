targetScope = 'subscription'

param subscriptionId string = ''
param rgName string = '${namePrefix}-${env}-${suffix}-rg'
param env string = 'dev'
param namePrefix string = 'cayers'
param suffix string = ''
param location string = 'eastus'
param addressPrefixes array = [
  '10.0.0.0/16'
]

module rg 'modules/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-${env}-${suffix}'
  scope: subscription(subscriptionId)
  params: {
    // Required parameters
    name: rgName
    location: location
  }
}

module vnet 'modules/Microsoft.Network/virtualNetworks/deploy.bicep' = {
  name: '${uniqueString(deployment().name, location)}-${env}-msdn'
  scope: resourceGroup(subscriptionId, rgName)
  dependsOn: [
    rg
  ]
  params: {
    // Required parameters
    addressPrefixes: addressPrefixes
    name: '${namePrefix}-${env}-${suffix}-vnet'
    location: location
  }
}

output vnetName string = vnet.outputs.name
