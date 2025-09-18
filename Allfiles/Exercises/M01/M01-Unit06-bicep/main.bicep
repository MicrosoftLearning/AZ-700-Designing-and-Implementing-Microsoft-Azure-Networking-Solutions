//This bicep template performs the following tasks: 

//Task 1: Create a private DNS Zone
//Task 2: Link subnet for auto registration
//Task 3: Create Virtual Machines to test the configuration


@description('description')
param vmName1 string

@description('description')
param nicName1 string

@description('description')
param vmName2 string

param location string = resourceGroup().location

@description('description')
param nicName2 string

@description('Virtual machine size')
param vmSize string = 'Standard_D2s_v3'

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

param privateDnsZoneName string = 'contoso.com'
param privateDnsZoneLinkName string = 'CoreServicesVnetLink'
param autoVmRegistration bool = true

var virtualNetworkName = 'CoreServicesVnet'
var nsgName1_var = 'testvm1-nsg'
var nsgName2_var = 'testvm2-nsg'
var PIPName1_var = 'testvm1-pip'
var PIPName2_var = 'testvm2-pip'
var subnetName = 'DatabaseSubnet'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
var vnetId = resourceId('Microsoft.Network/virtualNetworks', virtualNetworkName)

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZoneName
  location: 'global'
}

resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  name: '${privateDnsZone.name}/${privateDnsZoneLinkName}'
  location: 'global'
  properties: {
    registrationEnabled: autoVmRegistration
    virtualNetwork: {
      id: vnetId
    }
  }
}


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

resource vmName2_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
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
          id: nicName2_resource.id
        }
      ]
    }
  }
}

resource nicName2_resource 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName2
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
            id: PIPName2.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgName2.id
    }
  }
}

resource nsgName2 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgName2_var
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

resource PIPName2 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: PIPName2_var
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
