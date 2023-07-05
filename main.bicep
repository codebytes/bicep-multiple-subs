targetScope = 'managementGroup'

param sub1SubscriptionId string = ''
param sub1Suffix string = ''
param sub2SubscriptionId string = ''
param sub2Suffix string = ''
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

module customVnet './custom-vnet.bicep' = {
  name: '${uniqueString(deployment().name)}-${env}-${sub2Suffix}-vnet'
  scope: subscription(sub2SubscriptionId)
  params: {
    subscriptionId: sub2SubscriptionId
    env: env
    namePrefix: namePrefix
    rgName: sub2RGName
    suffix: sub2Suffix
    location: location
    addressPrefixes: [
      '10.0.0.0/16'
    ]
  }  
}

module storage './modules/Microsoft.Storage/storageAccounts/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-${env}-${sub2Suffix}-stg'
  scope: resourceGroup(sub2SubscriptionId, sub2RGName)
  params: {
    // Required parameters
    name: '${namePrefix}${env}${sub2Suffix}stg'
    location: location
  }
}
