---
demo:
    module: 'Module 05 - Load balancing HTTPS traffic'
    title: "Application Gateway (Module 05)"
---
## Configure Azure Application Gateway

In this demonstration, we will learn how to create an Azure Application Gateway. 

**Simulation:** [Deploy an Azure Application Gateway](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Deploy%20Azure%20Application%20Gateway)

**Reference**: [Quickstart: Direct web traffic with Azure Application Gateway - Azure portal](https://learn.microsoft.com/azure/application-gateway/quick-create-portal)

**Reference**: [Encrypt network traffic end-to-end with Azure Application Gateway](https://github.com/MicrosoftDocs/mslearn-end-to-end-encryption-with-app-gateway)

**Note**: To keep things simple, create new virtual networks and subnets as you go through the configuration. 

**Create the Azure Application Gateway**

1. Access the Azure portal.

1. Search for and select **Azure Application Gateway**.

1. **Create** a new gateway.

1. On the **Basics** tab, discuss **Tiers**, **Autoscaling**, and **Instance counts**.

1. On the **Frontends** tab, discuss the IP address types.

1. On the **Backends** tab, discuss when to use an empty backend pool.

1. On the **Configuration** tab, discuss routing rules. Compare to the load balancer rules.

1. Explain that after gateway is created, you would then add backend targets and test. 
