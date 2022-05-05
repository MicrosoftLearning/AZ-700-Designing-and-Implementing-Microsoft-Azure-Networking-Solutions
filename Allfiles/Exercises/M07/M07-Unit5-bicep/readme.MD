Deploy the following bicep template to create the virtual network, subnets and VMs needed for this exercise

```
$RGName = "myResourceGroup"

New-AzResourceGroup -Name $RGName -Location 'EastUS'

New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile main.bicep -TemplateParameterFile azuredeploy.parameters.json
```

