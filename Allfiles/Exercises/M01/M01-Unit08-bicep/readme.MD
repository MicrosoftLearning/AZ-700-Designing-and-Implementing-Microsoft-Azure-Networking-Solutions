This Bicep template performs the following tasks:

Task 1: Creates a Virtual Machine to test the configuration
Task 4: Creates VNet peerings between CoreServicesVnet and ManufacturingVnet

!important: You need to first deploy the main.bicep file from the previous lab "M01-Unit04-bicep" and "M01-Unit06-bicep"

1. Deploy the bicep template along with the parameters file using the command below: 

```
$date = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "AzInsiderDeployment"+"$date"

New-AzResourceGroupDeployment -Name $deploymentName -ResourceGroupName ContosoResourceGroup -TemplateFile .\main.bicep -TemplateParameterFile .\azuredeploy.parameters.json -c
```