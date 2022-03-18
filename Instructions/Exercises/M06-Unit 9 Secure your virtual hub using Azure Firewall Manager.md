---
Exercise:
    title: 'M06-Unit 9 Secure your virtual hub using Azure Firewall Manager'
    module: 'Module - Design and implement network security'
---


# M06-Unit 9 Secure your virtual hub using Azure Firewall Manager

In this exercise, you will create the spoke virtual network and create a secured virtual hub, then you will connect the hub and spoke virtual networks and route traffic to your hub. Next you will deploy the workload servers, then create a firewall policy and secure your hub, and finally you will test the firewall.

## Create a hub and spoke architecture

In this part of the exercise, you will create the spoke virtual networks and subnets where you will place the workload servers. Then you will create the secured virtual hub and connect the hub and spoke virtual networks.

In this exercise, you will:

+ Task 1: Create two spoke virtual networks and subnets
+ Task 2: Create the secured virtual hub
+ Task 3: Connect the hub and spoke virtual networks
+ Task 4: Deploy the servers
+ Task 5: Create a firewall policy and secure your hub
+ Task 6: Associate the firewall policy
+ Task 7: Route traffic to your hub
+ Task 8: Test the application rule
+ Task 9: Test the network rule
+ Task 10: Clean up resources

## Task 1: Create two spoke virtual networks and subnets

In this task, you will create the two spoke virtual networks each containing a subnet that will host your workload servers. 

1. On the Azure portal home page, in the search box, type **virtual network** and select **Virtual Network** when it appears.
2. Click **Create**.
3. In **Resource group**, select **Create new**, and enter **fw-manager-rg** as the name and click **OK**.
4. In **Name**, enter **Spoke-01**.
5. In **Region**, select your region.
6. Click **Next: IP Addresses**.
7. In **IPv4 address space**, enter **10.0.0.0/16**. 
8. **Delete** any other address spaces listed here, such as **10.1.0.0/16**.
9. Under **Subnet name**, click the word **default**.
10. In the **Edit subnet** dialog box, change the name to **Workload-01-SN**.
11. Change the **Subnet address range** to **10.0.1.0/24**.
12. Click **Save**.
13. Click **Review + create**.
14. Click **Create**.

Repeat steps 1 to 14 above to create another similar virtual network and subnet but using the following information:

- Resource Group: **fw-manager-rg** (select existing)
- Name: **Spoke-02**
- Address space: **10.1.0.0/16** - (delete any other listed address spaces)
- Subnet name: **Workload-02-SN**
- Subnet address range: **10.1.1.0/24**

## Task 2: Create the secured virtual hub

In this task you will create your secured virtual hub using Firewall Manager.

1. From the Azure portal home page, click **All services**.

2. In the search box, type **firewall manager** and select **Firewall Manager** when it appears.

3. On the **Firewall Manager** page, from the Overview page, click **View secured virtual hubs**.

4. On the **Virtual hubs** page, click **Create new secured virtual hub**.

5. For **Resource group**, select **fw-manager-rg**.

6. For **Region**, select your region.

7. For the **Secured virtual hub name**, enter **Hub-01**.

8. For **Hub address space**, enter **10.2.0.0/16**.

9. Choose **New vWAN**.

10. In **Virtual WAN Name**, enter **Vwan-01**.

11. Click **Next: Azure Firewall**.
    ![Create new secured virtual hub - Basics tab](../media/create-new-secured-virtual-hub-1.png)

12. Click **Next: Security Partner Provider**.

13. Click **Next: Review + create.**

14. Click **Create**.

    > **[!NOTE]** 
    >
    > This can take up to 30 minutes to deploy.

    ​

    ![Create new secured virtual hub - Review + create tab](../media/create-new-secured-virtual-hub-2.png)

15. When the deployment completes, from the Azure portal home page, click **All services**.

16. In the search box, type **firewall manager** and select **Firewall Manager** when it appears.

17. On the **Firewall Manager** page, click **Virtual hubs**.

18. Click **Hub-01**.

19. Click **Public IP configuration**.

20. Note down the public IP address (e.g., **51.143.226.18**), which you will use later.

## Task 3: Connect the hub and spoke virtual networks

In this task you will connect the hub and spoke virtual networks. This is commonly known as peering.

1. From the Azure portal home page, click **Resource groups**.
2. Select the **fw-manager-rg** resource group, then select the **Vwan-01** virtual WAN.
3. Under **Connectivity**, click **Virtual network connections**.
4. Click **Add connection**.
5. For **Connection name**, enter **hub-spoke-01**.
6. For **Hubs**, select **Hub-01**.
7. For **Resource group**, select **fw-manager-rg**.
8. For **Virtual network**, select **Spoke-01**.
9. Click **Create**.
   ![Add hub and spoke connection to virtual WAN - Spoke 1](../media/connect-hub-spoke-vnet-1.png)
10. Repeat steps 4 to 9 above to create another similar connection but using the connection name of **hub-spoke-02** to connect the **Spoke-02** virtual network.

![Add hub and spoke connection to virtual WAN - Spoke 2](../media/connect-hub-spoke-vnet-2.png)

 

## Task 4: Deploy the servers

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. In the toolbar of the Cloud Shell pane, select the Upload/Download files icon, in the drop-down menu, select Upload and upload the following files **FirewallManager.json** and **FirewallManager.parameters.json** into the Cloud Shell home directory one by one from the source folder **F:\Allfiles\Exercises\M06**.

3. Deploy the following ARM templates to create the VM needed for this exercise:

   ```powershell
   $RGName = "fw-manager-rg"
   
   New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile FirewallManager.json -TemplateParameterFile FirewallManager.parameters.json
   ```
  
4. When the deployment is complete, go to the Azure portal home page, and then select **Virtual Machines**.

5. On the **Overview** page of **Srv-workload-01**, in the right-hand pane, under the **Networking** section, note down the **Private IP address** (e.g., **10.0.1.4**).

6. On the **Overview** page of **Srv-workload-02**, in the right-hand pane, under the **Networking** section, note down the **Private IP address** (e.g., **10.1.1.4**).


## Task 5: Create a firewall policy and secure your hub

In this task you will first create your firewall policy, then secure your hub. The firewall policy will define collections of rules to direct traffic on one or more Secured virtual hubs.

1. From the Azure portal home page, click **Firewall Manager**.
   - If the Firewall Manager icon does not appear on the homepage, then click **All services**. Then in the search box, type **firewall manager** and select **Firewall Manager** when it appears.

2. From **Firewall Manager**, from the Overview page, click **View Azure Firewall Policies**.

3. Click **Create Azure Firewall Policy**.

4. In **Resource group**, select **fw-manager-rg**.

5. Under **Policy details**, for the **Name**, enter **Policy-01**.

6. In **Region** select your region.

7. In **Policy tier**, select **Standard**.

8. Click **Next : DNS Settings**.

8. Click **Next : TLS Inspection (preview)**.

9. Click **Next : Rules**.

10. On the **Rules** tab, click **Add a rule collection**.

11. On the **Add a rule collection** page, in **Name**, enter **App-RC-01**.

12. For **Rule collection type**, select **Application**.

13. For **Priority**, enter **100**.

14. Ensure **Rule collection action** is **Allow**.

15. Under **Rules**, in **Name** type **Allow-msft**.

16. For the **Source type**, select **IP Address**.

17. For **Source**, enter *.

18. For **Protocol**, enter **http,https**.

19. Ensure **Destination type** is **FQDN**.

20. For **Destination**, enter ***.microsoft.com**.

21. Click **Add**.

    ![Add application rule collection to firewall policy](../media/add-rule-collection-firewall-policy-1.png)

22. To add a DNAT rule so you can connect a remote desktop to the Srv-workload-01 VM, click **Add a rule collection**.

23. For **Name**, enter **dnat-rdp**.

24. For **Rule collection type**, select **DNAT**.

25. For **Priority**, enter **100**.

26. Under **Rules**, in **Name** enter **Allow-rdp**.

27. For the **Source type**, select **IP Address**.

28. For **Source**, enter *.

29. For **Protocol**, select **TCP**.

30. For **Destination Ports**, enter **3389**.

31. For **Destination Type**, select **IP Address**.

32. For **Destination**, enter the firewall virtual hub public IP address that you noted down earlier (e.g., **51.143.226.18**).

33. For **Translated address**, enter the private IP address for **Srv-workload-01** that you noted down earlier (e.g., **10.0.1.4**).

34. For **Translated port**, enter **3389**.

35. Click **Add**.

36. To add a Network rule so you can connect a remote desktop from Srv-workload-01 to Srv-workload-02 VM, click **Add a rule collection**.

37. For **Name**, enter **vnet-rdp**.

38. For **Rule collection type**, select **Network**.

39. For **Priority**, enter **100**.

40. For **Rule collection action**, select **Allow**.

41. Under **Rules**, in **Name** enter **Allow-vnet**.

42. For the **Source type**, select **IP Address**.

43. For **Source**, enter *.

44. For **Protocol**, select **TCP**.

45. For **Destination Ports**, enter **3389**.

46. For **Destination Type**, select **IP Address**.

47. For **Destination**, enter the private IP address for **Srv-workload-02** that you noted down earlier (e.g., **10.1.1.4**).

48. Click **Add**.

    ![List rule collections in the firewall policy](../media/list-rule-collections-firewall-policy.png)

49. You should now have 3 rule collections listed.

50. Click **Review + create**.

51. Click **Create**.

## Task 6: Associate the firewall policy

In this task you will associate the firewall policy with the virtual hub.

1. From the Azure portal home page, click **Firewall Manager**.
   - If the Firewall Manager icon does not appear on the homepage, then click **All services**. Then in the search box, type **firewall manager** and select **Firewall Manager** when it appears.
2. In **Firewall Manager**, under **Security**, click **Azure Firewall Policies**.
3. Select the checkbox for **Policy-01**.
4. Select **Manage associations&gt;Associate hubs**.
5. Select the checkbox for **Hub-01**.
6. Click **Add**.
7. When the policy has been attached, click **Refresh**. The association should be displayed.

![Show associated firewall policy on hub](../media/associate-firewall-policy-with-hub-end.png)

 

## Task 7: Route traffic to your hub

In this task you will ensure that network traffic gets routed through your firewall.

1. In **Firewall Manager**, click **Virtual hubs**.
2. Click **Hub-01**.
3. Under **Settings**, click **Security configuration**.
4. In **Internet traffic**, select **Azure Firewall**.
5. In **Private traffic**, select **Send via Azure Firewall**.
6. Click **Save**. 
7. This will take a few minutes to complete.
8. Once configuration has completed, ensure that under **INTERNET TRAFFIC** and **PRIVATE TRAFFIC**, it says **Secured by Azure Firewall** for both hub-spoke connections.


## Task 8: Test the application rule

In this part of the exercise, you will connect a remote desktop to the firewall public IP address, which is NATed to Srv-Workload-01. You will then use a web browser to test the application rule and connect a remote desktop to Srv-Workload-02 to test the network rule.

In this task you will test the application rule to confirm that it works as expected.

1. Open **Remote Desktop Connection** on your PC.

2. In the **Computer** box, enter the **firewall's public IP address** (e.g., **51.143.226.18**).

3. Click **Show Options**.

4. In the **Username** box, enter **TestUser**.

5. Click **Connect**.

   ![RDP connection to srv-workload-01](../media/rdp-srv-workload-01.png)

6. In the **Enter your credentials** dialog box, log into the **Srv-workload-01** server virtual machine, by using the password, **TestPa$$w0rd!**.

7. Click **OK**.

8. Click **Yes** on the certificate message.

9. Open Internet Explorer and click **OK** in the **Set up Internet Explorer 11** dialog box.

10. Browse to **https://** **www.microsoft.com**.

11. In the **Security Alert** dialog box, click **OK**.

12. Click **Close** on the Internet Explorer security alerts that may pop-up.

13. You should see the Microsoft home page.

    ![RDP session browsing microsoft.com](../media/microsoft-home-page.png)

14. Browse to **https://** **www.google.com**.

15. You should be blocked by the firewall.

    ![RDP session browser blocked on google.com](../media/google-home-page-fail.png)

16. So, you have verified that you can connect to the one allowed FQDN but are blocked from all others.

## Task 9: Test the network rule

In this task you will test the network rule to confirm that it works as expected.

1. While still logged in to the **Srv-workload-01** RDP session, from this remote computer, open **Remote Desktop Connection**.

2. In the **Computer** box, enter the **private IP address** of **Srv-workload-02** (e.g., **10.1.1.4**).

3. In the **Enter your credentials** dialog box, log in to the **Srv-workload-02** server by using the username **TestUser**, and a password of **TestPa$$w0rd!**.

4. Click **OK**.

5. Click **Yes** on the certificate message.

   ![RDP session from srv-workload-01 to another RDP session on srv-workload-02](../media/rdp-srv-workload-02-from-srv-workload-01.png)

6. So, now you have verified that the firewall network rule is working, as you have connected a remote desktop from one server to another server located in another virtual network.

7. Close both RDP sessions to disconnect them.


## Task 10: Clean up resources 

>**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell
   Remove-AzResourceGroup -Name 'fw-manager-rg' -Force -AsJob
   ```

    >**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
