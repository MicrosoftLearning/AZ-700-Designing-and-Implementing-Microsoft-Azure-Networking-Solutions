This bicep file creates the following: 

 - 1 virtual network
 - 2 subnets
 - 2 virtual machines and extensions
 - 2 network interfaces

 To deploy the bicep file: 

```
 $RGName = "ContosoResourceGroup"
   
New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile main.bicep -TemplateParameterFile azuredeploy.parameters.json
```

When the deployment is complete, go to the Azure portal home page, and then select Virtual Machines.

Verify that both virtual machines have been created.

Now proceed to create the Application Gateway as shown in https://microsoftlearning.github.io/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/Instructions/Exercises/M05-Unit%204%20Deploy%20Azure%20application%20gateway.html