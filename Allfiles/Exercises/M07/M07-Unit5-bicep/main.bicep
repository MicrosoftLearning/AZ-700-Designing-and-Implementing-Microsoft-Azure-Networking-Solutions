//This bicep template creates a virtual network with 2 subnets and 2 virtual machines

param location string = 'eastus'

@description('description')
param vmName1 string

@description('description')
param nicName1 string

@description('description')
param vmName2 string

@description('description')
param nicName2 string

@description('Virtual machine size')
param vmSize string = 'Standard_D2s_v3'

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

var virtualNetworkName = 'CoreServicesVNet'
var nsg1_var = 'ContosoPublic-nsg'
var nsg2_var = 'ContosoPrivate-nsg'
var pip1_var = 'ContosoPublic-ip'
var pip2_var = 'ContosoPrivate-ip'
var subnetName1 = 'Public'
var subnetName2 = 'Private'
var subnetRef1 = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName1)
var subnetRef2 = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName2)

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName1
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: subnetName2
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource vm1 'Microsoft.Compute/virtualMachines@2021-11-01' = {
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
          id: nic1.id
        }
      ]
    }
  }
}

resource nic1 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef1
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip1.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg1.id
    }
  }
}

resource nsg1 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsg1_var
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

resource vm2 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmName2
  location: location
  properties: {
    osProfile: {
      computerName: vmName2
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
          id: nic2.id
        }
      ]
    }
  }
}

resource nic2 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName2
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef2
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip2.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg2.id
    }
  }
}

resource nsg2 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsg2_var
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

resource pip1 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: pip1_var
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

resource pip2 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: pip2_var
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
