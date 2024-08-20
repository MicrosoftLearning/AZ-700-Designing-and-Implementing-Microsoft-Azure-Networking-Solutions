---
Exercise:
    title: 'M03 - Unit 5 Provision an ExpressRoute circuit'
    module: 'Module 03 - Design and implement Azure ExpressRoute'
---

# M03 - Unit 5 Provision an ExpressRoute circuit

## Exercise scenario

In this exercise, you will create an ExpressRoute circuit using the Azure portal and the Azure Resource Manager deployment model.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Provision%20an%20ExpressRoute%20circuit)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same.

### Estimated time: 15 minutes

![Diagram ExpressRoute circuit layout for exercise](../media/5-exercise-provision-expressroute-circuit.png)

In this exercise, you will:

+ Task 1: Create and provision an ExpressRoute circuit
+ Task 2: Retrieve your Service key
+ Task 3: Deprovisioning an ExpressRoute circuit
+ Task 4: Clean up resources

## Task 1: Create and provision an ExpressRoute circuit

1. From a browser, navigate to the [Azure portal](https://portal.azure.com/) and sign in with your Azure account.

   > **IMPORTANT**
   >
   > Your ExpressRoute circuit is billed from the moment a service key is issued. Ensure that you perform this operation when the connectivity provider is ready to provision the circuit.

1. On the Azure portal menu, select **+ Create a resource**. Select **Networking**, and then select **ExpressRoute**, as shown in the following image. If ExpressRoute does not appear in the list, use **Search the marketplace** to search for it:

   ![Azure portal - create ExpressRoute circuit menu](../media/create-expressroute-circuit-menu.png)

1. On the **Create ExpressRoute** page, provide the **Resource Group**, **Region**, and **Name** for the circuit with the following: ExpressRouteResourceGroup, East US 2, TestERCircuit. Then select **Next: Configuration &gt;**.

1. When you are filling in the values on this page, for this example, make sure that you specify the correct SKU tier (**Standard**) data metering billing model (**Metered**) Provider (**Equinix**) Peering location (**Seattle**) and Bandwidth (**50Mbps**).

1. Select **Review + Create**.

1. Confirm that the ExpressRoute configuration passes validation and then select **Create**.

   ![Azure portal - Create ExpressRoute configuration tab](../media/expressroute-create-configuration2.png)

   + Port type determines if you are connecting to a service provider or directly into Microsoft's global network at a peering location.
   + Create new or import from classic determines if a new circuit is being created or if you are migrating a classic circuit to Azure Resource Manager.
   + Provider is the internet service provider who you will be requesting your service from.
   + Peering Location is the physical location where you are peering with Microsoft.

   > **IMPORTANT**
   >
   > The Peering Location indicates the [physical location](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations) where you are peering with Microsoft. This is not linked to "Location" property, which refers to the geography where the Azure Network Resource Provider is located. While they are not related, it is a good practice to choose a Network Resource Provider geographically close to the Peering Location of the circuit.

   + **SKU** determines whether an ExpressRoute local, ExpressRoute standard, or an ExpressRoute premium add-on is enabled. You can specify **Local** to get the local SKU, **Standard** to get the standard SKU or **Premium** for the premium add-on. You can change the SKU to enable the premium add-on.

   > **IMPORTANT**
   >
   > You cannot change the SKU from Standard/Premium to Local.

   + **Billing model** determines the billing type. You can specify **Metered** for a metered data plan and **Unlimited** for an unlimited data plan. You can change the billing type from **Metered** to **Unlimited**.

   > **IMPORTANT**
   >
   > You cannot change the type from Unlimited to Metered.

   + **Allow classic operation** will allow classic virtual networks to be link to the circuit.

## Task 2: Retrieve your Service key

1. You can view all the circuits that you created by selecting **All services &gt; Networking &gt; ExpressRoute circuits**.

   ![Azure portal - Create ExpressRoute resource menu](../media/expressroute-circuit-menu.png)

1. All ExpressRoute circuits created in the subscription will appear here.

   ![Azure portal - show existing Expressroute circuits](../media/expressroute-circuit-list.png)

1. The circuit page displays the properties of the circuit. The service key appears in the service key field. Your service provider will need the Service Key to complete the provisioning process. The service key is specific to your circuit. **You must send the service key to your connectivity provider for provisioning.**

   ![Azure portal - ExpressRoute Circuit properties showing service key](../media/expressroute-circuit-overview.png)

1. On this page, **Provider status** gives you the current state of provisioning on the service-provider side. **Circuit status** provides you the state on the Microsoft side.

1. When you create a new ExpressRoute circuit, the circuit is in the following state:

   + Provider status: Not provisioned
   + Circuit status: Enabled

   + The circuit changes to the following state when the connectivity provider is currently enabling it for you:
     + Provider status: Provisioning
     + Circuit status: Enabled
   + To use the ExpressRoute circuit, it must be in the following state:
     + Provider status: Provisioned
     + Circuit status: Enabled
   + You should periodically check the provisioning status and the state of the circuit status.

   ![Azure portal - ExpressRoute circuit properties showing status is now provisioned](../media/provisioned.png)

Congratulations! You have created an ExpressRoute circuit and located the Service key, which you would need to complete the provisioning of the circuit.

## Task 3: Deprovisioning an ExpressRoute circuit

If the ExpressRoute circuit service provider provisioning state is **Provisioning** or **Provisioned,** you must work with your service provider to deprovision the circuit on their side. Microsoft can continue to reserve resources and bill you until the service provider completes deprovisioning the circuit and notifies us.

> **NOTE**
>
> You must unlink all virtual networks from the ExpressRoute circuit before deprovisioning. If this operation fails, check whether any virtual networks are linked to the circuit.
>
> If the service provider has deprovisioned the circuit (the service provider provisioning state is set to Not provisioned), you can delete the circuit. This stops billing for the circuit.

## Task 4: Clean up resources

You can delete your ExpressRoute circuit by selecting the **Delete** icon. Ensure the provider status is Not provisioned before proceeding.

![Azure portal - delete an ExpressRoute circuit](../media/expressroute-circuit-delete.png)

   > **Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. On the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell
   Remove-AzResourceGroup -Name 'ContosoResourceGroup' -Force -AsJob
   Remove-AzResourceGroup -Name 'ExpressRouteResourceGroup' -Force -AsJob
   ```

   > **Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
