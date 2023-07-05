targetScope = 'managementGroup'

param sub1SubscriptionId string = ''
param sub1Suffix string = ''
param sub1AddressPrefixes array = [
  '10.0.0.0/16'
]

param sub2SubscriptionId string = ''
param sub2Suffix string = ''
param sub2AddressPrefixes array = [
  '10.1.0.0/16'
]

param env string = 'dev'
param namePrefix string = ''
param location string = 'eastus'

var sub1RGName = '${namePrefix}-${env}-${sub1Suffix}-rg'
var sub2RGName = '${namePrefix}-${env}-${sub2Suffix}-rg'

module sub1RG 'modules/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-${env}-${sub1Suffix}'
  scope: subscription(sub1SubscriptionId)
  params: {
    // Required parameters
    name: sub1RGName
    location: location
  }
}

module sub2RG 'modules/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-${env}-${sub2Suffix}'
  scope: subscription(sub2SubscriptionId)
  params: {
    // Required parameters
    name: sub2RGName
    location: location
  }
}


module vnet1 'modules/Microsoft.Network/virtualNetworks/deploy.bicep' = {
  name: '${uniqueString(deployment().name, location)}-${env}-vnet1'
  scope: resourceGroup(sub1SubscriptionId, sub1RGName)
  dependsOn: [
    sub1RG
  ]
  params: {
    // Required parameters
    addressPrefixes: sub1AddressPrefixes
    name: '${namePrefix}-${env}-${sub1Suffix}-vnet'
    location: location
  }
}

module vnet2 'modules/Microsoft.Network/virtualNetworks/deploy.bicep' = {
  name: '${uniqueString(deployment().name, location)}-${env}-vnet2'
  scope: resourceGroup(sub2SubscriptionId, sub2RGName)
  dependsOn: [
    sub2RG
  ]
  params: {
    // Required parameters
    addressPrefixes: sub2AddressPrefixes
    name: '${namePrefix}-${env}-${sub2Suffix}-vnet'
    location: location
  }
}
