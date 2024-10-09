---
demo:
    module: 'Module 01 - Introduction to Azure Virtual Networks'
    title: 'Custom Routes'
---
In this demonstration, we will learn how to create a route table, define a custom route, and associate the route with a subnet.

**Reference:** [Tutorial: Route network traffic with a route table using the Azure portal](https://learn.microsoft.com/azure/virtual-network/tutorial-create-route-table-portal)

**Reference:** [Quickstart: Create an Azure Route Server using the Azure portal](https://learn.microsoft.com/azure/route-server/quickstart-create-route-server-portal)

**Note**: This demonstration requires a virtual network with at least one subnet.

## Create a routing table
1. Access the Azure portal.
1. Navigate to **Route tables**.
1. Select **+ Create**.
    **Name**: myRouteTablePublic
   
    **Subscription**: select your subscription
   
    **Resource group**: create or select a resource group
   
    **Region**: select your location
   
    **Virtual network gateway route propagation**: Enabled
   
1. Select **Create**.
1. Wait for the new routing table to be deployed.

## Add a route
1. Select your new routing table, and then select **Routes**.
1. Select **+ Add**.
    **Name**: ToPrivateSubnet
   
    **Address prefix**: 10.0.1.0/24
   
    **Next hop type**: Virtual appliance
   
    **Next hop address**: 10.0.2.4
   
1. Read the information and ensure you have IP forwarding enabled on your virtual appliance. You can enable this by navigating to the respective network interface's IP address settings.
1. Select **Create**.
1. Wait for the new route to be deployed.

## Associate a route table to a subnet
1. Navigate to the subnet you want to associate with the routing table.
1. Select **Route table**.
1. Select your new routing table, **myRouteTablePublic**.
1. Save your changes.
1. Open the **Cloud Shell**. Select **PowerShell**. 
1. View information about your new routing table.
    **Get-AzRouteTable**
1. Verify the Routes and Subnet information is correct.

