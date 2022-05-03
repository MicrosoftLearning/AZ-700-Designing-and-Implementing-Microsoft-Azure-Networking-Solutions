//This template creates three VNets, and their associated subnets.
param location01 string = 'eastus'
param location02 string = 'westeurope'
param location03 string = 'southeastasia'

param virtualNetworks_ResearchVnet_name string = 'ResearchVnet'
param virtualNetworks_CoreServicesVnet_name string = 'CoreServicesVnet'
param virtualNetworks_ManufacturingVnet_name string = 'ManufacturingVnet'


resource vnet_CoreServices 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworks_CoreServicesVnet_name
  location: location01
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.20.0.0/27'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SharedServicesSubnet'
        properties: {
          addressPrefix: '10.20.10.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'DatabaseSubnet'
        properties: {
          addressPrefix: '10.20.20.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'PublicWebServiceSubnet'
        properties: {
          addressPrefix: '10.20.30.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vnet_Manufacturing 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_ManufacturingVnet_name
  location: location02
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.30.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ManufacturingSystemSubnet'
        properties: {
          addressPrefix: '10.30.10.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SensorSubnet1'
        properties: {
          addressPrefix: '10.30.20.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SensorSubnet2'
        properties: {
          addressPrefix: '10.30.21.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SensorSubnet3'
        properties: {
          addressPrefix: '10.30.22.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vnet_Research 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_ResearchVnet_name
  location: location03
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.40.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ResearchSystemSubnet'
        properties: {
          addressPrefix: '10.40.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_CoreServicesVnet_name_DatabaseSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_CoreServices
  name: 'DatabaseSubnet'
  properties: {
    addressPrefix: '10.20.20.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_CoreServicesVnet_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_CoreServices
  name: 'GatewaySubnet'
  properties: {
    addressPrefix: '10.20.0.0/27'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_ManufacturingVnet_name_ManufacturingSystemSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_Manufacturing
  name: 'ManufacturingSystemSubnet'
  properties: {
    addressPrefix: '10.30.10.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_CoreServicesVnet_name_PublicWebServiceSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_CoreServices
  name: 'PublicWebServiceSubnet'
  properties: {
    addressPrefix: '10.20.30.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_ResearchVnet_name_ResearchSystemSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_Research
  name: 'ResearchSystemSubnet'
  properties: {
    addressPrefix: '10.40.40.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_ManufacturingVnet_name_SensorSubnet1 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_Manufacturing
  name: 'SensorSubnet1'
  properties: {
    addressPrefix: '10.30.20.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_ManufacturingVnet_name_SensorSubnet2 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_Manufacturing
  name: 'SensorSubnet2'
  properties: {
    addressPrefix: '10.30.21.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_ManufacturingVnet_name_SensorSubnet3 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_Manufacturing
  name: 'SensorSubnet3'
  properties: {
    addressPrefix: '10.30.22.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_CoreServicesVnet_name_SharedServicesSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: vnet_CoreServices
  name: 'SharedServicesSubnet'
  properties: {
    addressPrefix: '10.20.10.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
