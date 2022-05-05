Deploy the following ARM templates to create the PremiumV2-tier Azure Web App needed for this exercise:

```
$RGName = "CreatePrivateEndpointQS-rg"

New-AzResourceGroup -Name $RGName -Location 'EastUS'

New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile main.bicep -TemplateParameterFile azuredeploy.parameters.json
```

Note: If you receive an error (for example while looking into the Deployment status in the Portal) like “Website with given name GEN-UNIQUE already exists.” please make sure to go to the 'azuredeploy.parameters.json' and provide a unique name for the value: webAppName