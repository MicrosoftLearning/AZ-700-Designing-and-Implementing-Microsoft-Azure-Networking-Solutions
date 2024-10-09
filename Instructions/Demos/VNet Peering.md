---
demo:
    title: 'VNET Peering            '
    module: 'Module 01 - Introduction to Azure Virtual Networks'
---
Configure VNet Peering
Note: For this demonstration you will need two virtual networks.
Configure VNet peering on the first virtual network
In the Azure portal, select the first virtual network.
Under Settings, select Peerings.
Select + Add.
Provide a Peering link name for This virtual network peering. For example, VNet1toVNet2.
Provide a Peering link name for the Remote virtual network peering. For example, VNet2toVNet1.
In the Virtual network drop-down, select the Remote virtual network you would like to peer with ensuring you also select the correct Subscription.
Use the informational icons to review the Traffic to remote virtual network Traffic forwarded from remote virtual network, and Virtual network gateway or Route Server settings. If you do not have a VPN Gateway, those settings will be greyed out.
Select Add to save your settings.
On the Peerings page, discuss the Peering Status.
Confirm VNet peering on the second virtual network
In the Azure portal, select the second virtual network
Under Settings, select Peerings.
Notice that a peering has automatically been created. The name is what you provided when the first virtual network peering was configured.
Notice that the Peering Status is Connected.
Discuss how the settings could be changed.
Cancel your changes.


