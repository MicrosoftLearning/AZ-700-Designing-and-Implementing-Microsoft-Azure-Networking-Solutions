
In this unit, you will configure enable connectivity between the CoreServicesVnet and the ManufacturingVnet by adding peerings to allow traffic flow. 

## Create a Virtual Machine to test the configuration

In this section, you will create a test VM on the Manufacturing VNet to test the peering configuration.

### Create ManufacturingVM

1. On the Azure home page, select Virtual Machines.
2. In Virtual Machines, select **+ Add &gt; + Start with a preset configuration**.
   ![Virtual machines with + Add and + Start with a preset configuration highlighted.](../media/add-virtual-machine-preset.png)

3. In Choose recommended defaults that match your workload, under **Select a workload environment**, select **Dev/Test**.

4. Under **Select a workload type**, select **General purpose (D-Series)**, and then select **Continue to create a VM**.

5. Use the information in the following table to create your VM.

| **Tab**         | **Option**                                                   | **Value**                             |
| --------------- | ------------------------------------------------------------ | ------------------------------------- |
| Basics          | Resource group                                               | ContosoResourceGroup                  |
|                 | Virtual machine name                                         | ManufacturingVM                       |
|                 | Region                                                       | (Europe) North Europe                 |
|                 | Availability options                                         | No infrastructure redundancy required |
|                 | Image                                                        | Windows 10 Pro, Version 20H2 - Gen 1  |
|                 | Azure Spot instance                                          | Not selected                          |
|                 | Size                                                         | Standard_D2_v3 - 2vcpus, 8GiB memory  |
|                 | Username                                                     | TestUser                              |
|                 | Password                                                     | TestPa$$w0rd!                         |
|                 | Public inbound ports                                         | Allow selected ports                  |
|                 | Select inbound ports                                         | RDP (3389)                            |
|                 | I confirm I have an eligible Windows 10 license with multi-tenant hosting rights. | Selected                              |
| Disks           | No changes required                                          |                                       |
| Networking      | Virtual network                                              | ManufacturingVnet                     |
|                 | Subnet                                                       | DatabaseSubnet (10.30.10.0/24)        |
|                 | Public IP                                                    | (new) ManufacturingVM-ip              |
|                 | NIC network security group                                   | Basic                                 |
|                 | Public inbound ports                                         | Allow selected ports                  |
|                 | Select inbound ports                                         | RDP (3389)                            |
|                 | Load balancing                                               | Not selected                          |
| Management      | No changes required                                          |                                       |
| Advanced        | No changes required                                          |                                       |
| Tags            | No changes required                                          |                                       |
| Review + create | Review your settings and select Create                       |                                       |
|                 |                                                              |                                       |


6. When the deployment is complete, select **Go to resource**.

## Connect to the Test VMs using RDP

1. On the Azure Portal home page, select **Virtual Machines**.

2. Select **ManufacturingVM**.

3. In ManufacturingVM, select **Connect &gt; RDP**.

4. In ManufacturingVM | Connect, select **Download RDP file**.

5. Save the RDP file to your desktop.

6. Connect to ManufacturingVM using the RDP file, and the username and password you specified when you created the VM.

7. On the Azure Portal home page, select **Virtual Machines**.

8. Select **TestVM1**.

9. In TestVM1, select **Connect &gt; RDP**.

10. In TestVM1 | Connect, select **Download RDP file**.

11. Save the RDP file to your desktop.

12. Connect to TestVM1 using the RDP file, and the username and password you specified when you created the VM.

13. On both VMs, in **Choose privacy settings for your device**, select **Accept**.

14. On both VMs, in **Networks**, select **Yes**.

15. On TestVM1, open a PowerShell prompt, and run the following command: ipconfig

16. Note the IPv4 address. 

 

## Test the connection between the VMs

1. On the ManufacturingVM, open a PowerShell prompt.

2. Use the following command to verify that there is no connection to TestVM1 on CoreServicesVnet. Be sure to use the IPv4 address for TestVM1.

| PowerShell                               |
| ---------------------------------------- |
| Test-NetConnection 10.20.20.4 -port 3389 |


3. The test connection should fail, and you will see a result similar to the following:
   ![PowerShell window with Test-NetConnection 10.20.20.4 -port 3389 showing failed ](../media/test-netconnection-fail.png)

 

## Create VNet peerings between CoreServicesVnet and ManufacturingVnet

1. On the Azure home page, select **Virtual Networks**, and then select **CoreServicesVnet**.

2. In CoreServicesVnet, under **Settings**, select **Peerings**.
   ![screen shot of core services VNet Peering settings ](../media/create-peering-on-coreservicesvnet.png)

3. On CoreServicesVnet | Peerings, select **+ Add**.

4. Use the information in the following table to create the peering.

| **Section**                          | **Option**                                    | **Value**                             |
| ------------------------------------ | --------------------------------------------- | ------------------------------------- |
| This virtual network                 |                                               |                                       |
|                                      | Peering link name                             | CoreServicesVnet-to-ManufacturingVnet |
|                                      | Traffic to remote virtual network             | Allow (default)                       |
|                                      | Traffic forwarded from remote virtual network | Allow (default)                       |
|                                      | Virtual network gateway or Route Server       | None (default)                        |
| Remote virtual network               |                                               |                                       |
|                                      | Peering link name                             | ManufacturingVnet-to-CoreServicesVnet |
|                                      | Virtual network deployment model              | Resource manager                      |
|                                      | I know my resource ID                         | Not selected                          |
|                                      | Subscription                                  | MOC Subscription-lodxxxxxxxx          |
|                                      | Virtual network                               | ManufacturingVnet                     |
|                                      | Traffic to remote virtual network             | Allow (default)                       |
|                                      | Traffic forwarded from remote virtual network | Allow (default)                       |
|                                      | Virtual network gateway or Route Server       | None (default)                        |
| Review your settings and select Add. |                                               |                                       |
|                                      |                                               |                                       |


5. In CoreServicesVnet | Peerings, verify that the **CoreServicesVnet-to-ManufacturingVnet** peering is listed.

6. Under Virtual networks, select **ManufacturingVnet**, and verify the **ManufacturingVnet-to-CoreServicesVnet** peering is listed.

 

## Test the connection between the VMs

1. On the ManufacturingVM, open a PowerShell prompt.

2. Use the following command to verify that there is now a connection to TestVM1 on CoreServicesVnet. 

| PowerShell                               |
| ---------------------------------------- |
| Test-NetConnection 10.20.20.4 -port 3389 |


3. The test connection should succeed, and you will see a result similar to the following:
   ![Powershell window with Test-NetConnection 10.20.20.4 -port 3389 showing TCP test succeeded: true](../media/test-connection-succeeded.png)

 

Congratulations! You have successful configured connectivity between VNets by adding peerings. 