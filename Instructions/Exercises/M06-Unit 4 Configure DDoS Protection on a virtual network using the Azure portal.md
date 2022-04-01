---
Exercise:
    title: 'M06-Unit 4 Configure DDoS Protection on a virtual network using the Azure portal'
    module: 'Module - Design and implement network security'
---

# M06-Unit 4 Configure DDoS Protection on a virtual network using the Azure portal

Being responsible for Contoso's Network Security team, you are going to run a mock DDoS attack on the virtual network. The following steps walk you through creating a virtual network, configuring DDoS Protection, and creating an attack which you can observe and monitor with the help of telemetry and metrics.

In this exercise, you will:

+ Task 1: Create a resource group
+ Task 2: Create a DDoS Protection plan
+ Task 3: Enable DDoS Protection on a new virtual network
+ Task 4: Configure DDoS telemetry
+ Task 5: Configure DDoS diagnostic logs
+ Task 6: Configure DDoS alerts
+ Task 7: Submit a DDoS service request to run a DDoS attack
+ Task 8: Clean up resources



## Task 1: Create a resource group

1. Log in to your Azure account.

2. On the Azure portal home page, select **Resource groups**.

3. Select **Create**. 

4. On the **Basics** tab, in **Resource group**, enter **MyResourceGroup**.

5. In **Region**, select East US.

6. Select **Review + create**.

7. Select **Create**.



## Task 2: Create a DDoS Protection plan

1. On the Azure portal home page, in the search box type **DDoS** and select **DDoS protection plan** when it appears.

2. Select **+ Create**.

3. On the **Basics** tab, in the **Resource group** list, select the resource group you just created.

4. In the **Instance name** box, type **MyDdoSProtectionPlan**, then select **Review + create**.

5. Select **Create**.

 

## Task 3: Enable DDoS Protection on a new virtual network

Here you will enable DDoS on a new virtual network rather than on an existing one, so first you need to create the new virtual network, then enable DDoS protection on it using the plan you created previously.

1. On the Azure portal home page, select **Create a resource**, then in the search box, type **Virtual Network**, then select **Virtual Network** when it appears.

2. On the **Virtual Network** page, select **Create**.

3. On the **Basics** tab, select the resource group you created previously.

4. In the **Name** box, type **MyVirtualNetwork**, then click the **Security** tab. 

5. On the **Security** tab, next to **DDoS Protection Standard**, select **Enable**.

6. In the **DDoS protection plan** drop-down list, select **MyDdosProtectionPlan**.

   ![Create virtual network - Security tab](../media/create-virtual-network-security-for-ddos-protection.png)

7. Click **Review + create**.

8. Click **Create**.

 

## Task 4: Configure DDoS telemetry

You create a Public IP address, and then set up telemetry in the next steps.

1. On the Azure portal home page, select **Create a resource**, then in the search box, type **public ip**, then click **Public IP address** when it appears.

2. On the **Public IP address** page, click **Create**.

3. On the **Create public IP address** page, under **SKU**, select **Basic**.

4. In the **Name** box, type **MyPublicIPAddress**.

5. Under **IP address assignment**, select **Static**.

6. In **DNS name label**, type **mypublicdnsxx** (where xx is your initials to make this unique).

7. Select your resource group from the list.

   ![Create public IP address](../media/create-public-ip-address-for-ddos-telemetry.png)

8. Click **Create**.

9. On the Azure home page, click **All resources**.

10. In the list of your resources, click **MyDdosProtectionPlan**.

11. Under **Monitoring**, select **Metrics**.

12. Select the **Scope** box, then select the checkbox next to **MyPublicIPAddress**.

    ![Create metrics scope for DDoS telemetry](../media/create-metrics-scope-for-ddos-telemetry.png)

13. Click **Apply**.

14. In the **Metrics** box, select **Inbound packets dropped DDoS**.

15. In the **Aggregation** box, select **Max**.

    ![Metrics created for DDoS telemetry](../media/metrics-created-for-ddos-telemetry.png)

 

## Task 5: Configure DDoS diagnostic logs

1. On the Azure home page, click **All resources**.

2. In the list of your resources, click **MyPublicIPAddress**.

3. Under **Monitoring**, select **Diagnostic settings**.

4. Click **Add diagnostic setting**. 

5. On the **Diagnostic setting** page, in the **Diagnostic setting name** box, type **MyDiagnosticSetting**. 

6. Under **Category details**, select all 3 **log** checkboxes and the **AllMetrics** checkbox.

7. Under **Destination details**, select the **Send to Log Analytics workspace** checkbox. Here, you could select a pre-existing Log Analytics workspace, but as you haven't set up a destination for the diagnostic logs yet, you will just enter the settings, but then discard them in the next step in this exercise.

   ![Configure new Diagnostic settings for DDoS](../media/configure-ddos-diagnostic-settings-new.png)

8. Normally you would now click **Save** to save your diagnostic settings. Note that this option is still grayed out as we cannot complete the setting configuration yet.

9. Click **Discard**, then click **Yes**.

 

## Task 6: Configure DDoS alerts

In this step you will create a virtual machine, assign a public IP address to it, and then configure DDoS alerts.

### Create the VM

1. On the Azure portal home page, select **Create a resource**, then in the search box, type **virtual machine**, then click **Virtual machine** when it appears.

2. On the **Virtual machine** page, click **Create**.

3. On the **Basics** tab, create a new VM using the information in the table below.

   | **Setting**           | **Value**                                                    |
   | --------------------- | ------------------------------------------------------------ |
   | Subscription          | Select your subscription                                     |
   | Resource group        | **MyResourceGroup**                                          |
   | Virtual machine name  | **MyVirtualMachine**                                         |
   | Region                | Your region                                                  |
   | Availability options  | **No infrastructure  redundancy required**                   |
   | Image                 | **Ubuntu Server 18.04 LTS -  Gen 1** (Select Configure VM Generation link if needed) |                     
   | Size                  | Select **See  all sizes**, then choose **B1ls** in the  list and choose **Select**  **(Standard_B1ls - 1 vcpu,  0.5 GiB memory** |
   | Authentication type   | **SSH public key**                                           |
   | Username              | **azureuser**                                                |
   | SSH public key source | **Generate new key pair**                                    |
   | Key pair name         | **myvirtualmachine-ssh-key**                                 |


4. Click **Review + create**.

5. Click **Create**.

6. In the **Generate new key pair** dialog box, click **Download private key and create resource**.

7. Save the private key.

8. When deployment is complete, click **Go to resource**.

### Assign the Public IP address

1. On the **Overview** page of the new virtual machine, under **Settings**, click **Networking**.

2. Next to **Network Interface**, click **myvirtualmachine-nic**. The name of the nic may differ.

3. Under **Settings**, click **IP configurations**.

4. Select **ipconfig1**.

5. In the **Public IP address** list, select **MyPublicIPAddress**.

6. Click **Save**.

   ![Change public IP address for DDoS VM](../media/change-public-ip-config-for-ddos-vm-new.png)

### Configure DDoS alerts

1. On the Azure home page, click **All resources**.

2. In the list of your resources, click **MyDdosProtectionPlan**.

3. Under **Monitoring**, select **Alerts**.

4. Click **New alert rule**.

5. On the **Create alert rule** page, under **Scope**, click **Edit resource**.

6. In the **Select a resource** pane, in the **Filter by resource type** box, scroll down the list and select **Public IP addresses**.

   ![New alert rule change scope to public IP address](../media/new-alert-rule-change-scope-to-public-ip-address-1.png)

7. In the **Resource** list, select **MyPublicIPAddress**, then click **Done**.

8. On the **Create alert rule** page, under **Condition**, click **Add condition**.

9. Select **Under DDoS attack or not**.

   ![Add condition to alert rule - select a signal](../media/add-condition-to-alert-rule-1.png)

10. In the **Operator** box select **Greater than or equal to**.

11. In **Threshold value**, enter **1** (means under attack).

12. Click **Done**.

    ![Add condition to alert rule - configure signal logic](../media/add-condition-to-alert-rule-2.png)

13. Back on the **Create alert rule** page, under the **Alert rule details** section and in **Alert rule name**, enter **MyDdosAlert**.

    ![End point of create new alert rule](../media/new-alert-rule-end.png)

14. Click **Create alert rule**.

 

## Task 7: Submit a DDoS service request to run a DDoS attack

1. Create an account with [BreakingPoint Cloud](https://breakingpoint.cloud/)

2. Set up your DDoS test as per the settings in the screenshot below (you may need to select the 100k pps test size with the trial account), but specifying the IP address of your own **MyPublicIPAddress** resource in the **Target IP Address** box (e.g., **51.140.137.219**)
   ![DDOSAttack](https://user-images.githubusercontent.com/46939028/138599420-58bef33a-2597-4fa2-919f-bf1614037bc3.JPG)

   ![DDoS Test Setup](../media/ddos-test-setup.png)

3. On the Azure portal home page, click **All resources**.

4. In the resources list, click your **MyPublicIPAddress** resource, then under **Monitoring**, click **Metrics**. 

5. In the **Metric** box, select **Under DDoS attack or not** from the list.

6. And here you can see DDoS attack as it happened. Note it may take the full 10 minutes before you see the results.

   ![Metrics showing resource under DDoS attack](../media/metrics-showing-resource-under-attack.png)

 
## Task 8: Clean up resources

>**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell
   Remove-AzResourceGroup -Name 'MyResourceGroup' -Force -AsJob
   ```

    >**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
