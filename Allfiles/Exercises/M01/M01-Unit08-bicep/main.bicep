//This Bicep template 

//Task 1: Creates a Virtual Machine to test the configuration
//Task 4: Creates VNet peerings between CoreServicesVnet and ManufacturingVnet

param location string = 'westeurope'

@description('description')
param vmName1 string

@description('description')
param nicName1 string

@description('Virtual machine size')
param vmSize string = 'Standard_D2s_v3'

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

var virtualNetworkName = 'ManufacturingVnet'
var nsgName1_var = 'ManufacturingVM-nsg'
var PIPName1_var = 'ManufacturingVM-ip'
var subnetName = 'ManufacturingSystemSubnet'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
var vnet0 = 'CoreServicesVnet'
var vnet1 = 'ManufacturingVnet'

var remoteVnetRg = 'azinsider_demo' //Change this to your resource group


resource vmName1_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmName1
  location: location
  properties: {
    osProfile: {
      computerName: vmName1
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: nicName1_resource.id
        }
      ]
    }
  }
}

resource nicName1_resource 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: PIPName1.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgName1.id
    }
  }
}

resource nsgName1 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgName1_var
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource PIPName1 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: PIPName1_var
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

//This creates a peering from CoreServicesVnet-to-ManufacturingVnet
resource peer1 'microsoft.network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  name: '${vnet0}/to-ManufacturingVnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(remoteVnetRg, 'Microsoft.Network/virtualNetworks', vnet1)
    }
  }
  dependsOn:[
    vmName1_resource
  ]
}

//This creates a peering from ManufacturingVnet-to-CoreServicesVnet
resource peer4 'microsoft.network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  name: '${vnet1}/to-CoreServicesVnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(remoteVnetRg, 'Microsoft.Network/virtualNetworks', vnet0)
    }
  }
  dependsOn:[
    vmName1_resource
  ]
}
