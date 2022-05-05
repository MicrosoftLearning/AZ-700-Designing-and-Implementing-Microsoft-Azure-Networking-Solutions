//This bicep template creates a vnet with two subnets, two virtual machines with extensions and two network interfaces
param location string = resourceGroup().location

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

var virtualNetworkName = 'ContosoVnet'
var subnet1Name = 'AGSubnet'
var subnet2Name = 'BackendSubnet'
var subnet2Ref = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnet2Name)


// This will build a Virtual Network.
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
        name: subnet1Name
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: subnet2Name
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
            id: subnet2Ref
          }
          privateIPAllocationMethod: 'Dynamic'
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
            id: subnet2Ref
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm1_extension 'Microsoft.Compute/virtualMachines/extensions@2018-06-01' = {
  name: '${vmName1}/VMConfig'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/master/Allfiles/Exercises/M05/install-iis.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
  }
  dependsOn: [
    vm1
  ]
}

resource vm2_extension 'Microsoft.Compute/virtualMachines/extensions@2018-06-01' = {
  name: '${vmName2}/VMConfig'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/master/Allfiles/Exercises/M05/install-iis.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
  }
  dependsOn: [
    vm2
  ]
}
