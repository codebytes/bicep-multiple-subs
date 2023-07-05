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

module vnet 'modules/Microsoft.Network/virtualNetworks/deploy.bicep' = {
  name: '${uniqueString(deployment().name, location)}-${env}-msdn'
  scope: resourceGroup(subscriptionId, rgName)
  params: {
    // Required parameters
    addressPrefixes: addressPrefixes
    name: '${namePrefix}-${env}-${suffix}-vnet'
    location: location
  }
}

output vnetName string = vnet.outputs.name
