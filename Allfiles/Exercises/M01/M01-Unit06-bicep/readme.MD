This bicep template performs the following tasks: 

Task 1: Creates a private DNS Zone
Task 2: Link subnet for auto registration
Task 3: Creates Virtual Machines to test the configuration

!important: You need to first deploy the main.bicep file from the previous lab (M01-Unit04-bicep). 

1. Deploy the bicep template along with the parameters file using the command below: 

```
$date = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "AzInsiderDeployment"+"$date"

New-AzResourceGroupDeployment -Name $deploymentName -ResourceGroupName ContosoResourceGroup -TemplateFile .\main.bicep -TemplateParameterFile .\azuredeploy.parameters.json -c
```