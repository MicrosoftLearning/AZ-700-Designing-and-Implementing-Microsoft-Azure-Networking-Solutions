---
demo:
    title: 'VPN Gateways (Module 02)'
    module: 'Module 02 - Design and implement hybrid networking'
---

**Simulation:** [Create and configure a virtual network gateway](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Create%20and%20configure%20a%20virtual%20network%20gateway)

In this demonstration, we will explore virtual network gateways.

**Note**: This demonstration works best with two virtual networks with subnets.

## Explore the Gateway subnet blade
1. For one of your virtual networks, select the **Subnets** blade.
1. Select **+ Gateway** subnet. Notice the name of the subnet cannot be changed. Notice the **address range** of the gateway subnet. The address must be contained by the address space of the virtual network.
1. Remember each virtual network needs a gateway subnet.
1. Close the Add gateway subnet page. You do not need to save your changes.

## Explore the Connected Devices blade
1. For the virtual network, select the **Connected Devices** blade.
1. After a gateway subnet is deployed it will appear on the list of connected devices.

## Explore adding a virtual network gateway
1. Search for **Virtual network gateways**.
1. Click **+ Add**.
1. Review each setting for the virtual network gateway.
1. Use the Information icons to learn more about the settings.
1. Notice the **Gateway type**, **VPN type**, and **SKU**.
1. Notice the need for a **Public IP address**.
1. Remember each virtual network will need a virtual network gateway.
1. Close the Add virtual network gateway. You do not need to save your changes.
   
## Explore adding a connection between the virtual networks
1. Search for **Connections**.
1. Click **+ Add**.
1. Notice the **Connection type** can be VNet-to-VNet, Site-to-Site (IPsec), or ExpressRoute.
1. Provide enough information, so you can click the **Ok** button.
1. On the **Settings** page, notice that you will need to select the two different virtual networks.
1. Read the Help information on the **Establish bidirectional connectivity** checkbox.
1. Notice the **Shared key (PSK)** information.
1. Close the Add connection page. You do not need to save your changes.
