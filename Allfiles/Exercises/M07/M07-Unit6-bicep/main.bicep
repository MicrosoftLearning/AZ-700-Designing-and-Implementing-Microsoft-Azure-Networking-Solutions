@description('Web app name.')
@minLength(2)
param webAppName string = 'webApp-${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The SKU of App Service Plan.')
param sku string = 'PremiumV2'
param skucode string = 'P1v2'

@description('The language stack of the app.')
@allowed([
  '.net'
  'php'
  'node'
  'html'
])
param language string = '.net'

@description('true = deploy a sample Hello World app.')
param helloWorld bool = false

@description('Optional Git Repo URL')
param repoUrl string = ''

var appPlan_var = 'AppServicePlan-${webAppName}'
var gitRepoReference = {
  '.net': 'https://github.com/Azure-Samples/app-service-web-dotnet-get-started'
  node: 'https://github.com/Azure-Samples/nodejs-docs-hello-world'
  php: 'https://github.com/Azure-Samples/php-docs-hello-world'
  html: 'https://github.com/Azure-Samples/html-docs-hello-world'
}
var gitRepoUrl = (bool(helloWorld) ? gitRepoReference[toLower(language)] : repoUrl)
var configReference = {
  '.net': {
    comments: '.Net app. No additional configuration needed.'
  }
  html: {
    comments: 'HTML app. No additional configuration needed.'
  }
  php: {
    phpVersion: '7.4'
  }
  node: {
    appSettings: [
      {
        name: 'WEBSITE_NODE_DEFAULT_VERSION'
        value: '12.15.0'
      }
    ]
  }
}

resource appPlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appPlan_var
  location: location
  sku: {
    tier: sku
    name: skucode
  }
}

resource webapp 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  location: location
  properties: {
    siteConfig: configReference[language]
    serverFarmId: appPlan.id
  }
}

resource sourceControl 'Microsoft.Web/sites/sourcecontrols@2020-06-01' = if (contains(gitRepoUrl, 'http')) {
  parent: webapp
  name: 'web'
  properties: {
    repoUrl: gitRepoUrl
    branch: 'master'
    isManualIntegration: true
  }
}
