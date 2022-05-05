This bicep template creates three VNets, and their associated subnets.

1. Create a resource group using Az PowerShell

```
new-azresourceGroup -Name "ContosoResourceGroup" -Location 'eastus'
```

2. Deploy the bicep template along with the parameters file using the command below: 

```
$date = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "AzInsiderDeployment"+"$date"

New-AzResourceGroupDeployment -Name $deploymentName -ResourceGroupName ContosoResourceGroup -TemplateFile .\main.bicep -TemplateParameterFile .\azuredeploy.parameters.json -c
```