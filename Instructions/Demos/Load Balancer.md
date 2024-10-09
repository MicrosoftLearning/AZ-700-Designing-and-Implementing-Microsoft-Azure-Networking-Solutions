---
demo:
    module: 'Module 04 - Load balancing non-HTTPS traffic'
    title: 'Load Balancer (Module 04)'
---
## Configure Azure Load Balancer

In this demonstration, we will learn how to create a public load balancer. 

**Simulation:** [Create and configure an Azure load balancer](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Create%20and%20configure%20an%20Azure%20load%20balancer)

**Reference**: [Quickstart: Create a public load balancer to load balance VMs using the Azure portal](https://learn.microsoft.com/azure/load-balancer/quickstart-load-balancer-standard-public-portal)

**Note:** This demonstration requires a virtual network with at least one subnet. 

**Show the portal's help me choose feature**

1. Access the Azure portal.

1. Search for and select **Load balancing - help me choose**.

1. Use the wizard to walk-through different scenarios.
   
**Create a load balancer**

1. Continue in the Azure portal.

1. Search for and select **Load balancer**. **Create** a load balancer. 

1. On the **Basics** tab, discuss **SKU**, **Type**, and **Tier**.

1. On the **Frontend IP configuration** tab, discuss using a public IP address.

1. On the **Backend pools** tab, select the virtual network with IP address range.

1. On the **Inbound rules** tab, create a load balancing rule. Discuss parameters like **Protocol**, **Ports**, **Health probes**, and **Session persistence**. 


