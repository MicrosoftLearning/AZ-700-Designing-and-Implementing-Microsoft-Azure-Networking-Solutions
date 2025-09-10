---
Exercise:
    title: 'M05 - Unit 6 Create a Front Door for a highly available web application using the Azure portal'
    module: 'Module 05 - Load balancing HTTP(S) traffic in Azure'
---



# M05-Unit 6 Create a Front Door for a highly available web application using the Azure portal

## Exercise scenario  

In this exercise, you will set up an Azure Front Door configuration that pools two instances of a web application that runs in different Azure regions. This configuration directs traffic to the nearest site that runs the application. Azure Front Door continuously monitors the web application. You will demonstrate automatic failover to the next available site when the nearest site is unavailable. The network configuration is shown in the following diagram:

![Network configuration for Azure Front Door.](../media/6-exercise-create-front-door-for-highly-available.png)

### Job skills

In this exercise, you will:

+ Task 1: Create two instances of a web app
+ Task 2: Create a Front Door for your application
+ Task 3: View Azure Front Door in action

### Interactive lab simulations

>**Note**: The lab simulations that were previously provided have been retired.

### Estimated time: 30 minutes

## Task 1: Create two instances of a web app

This exercise requires two instances of a web application that run in different Azure regions. Both the web application instances run in Active/Active mode, so either one can take traffic. This configuration differs from an Active/Stand-By configuration, where one acts as a failover.

1. Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).

1. On the Azure home page, using the global search enter **WebApp** and select **App Services** under services.

1. Select **+ Create** to create a Web App.

1. On the Create Web App page, on the **Basics** tab, enter or select the following information.

   | **Setting**      | **Value**                                                    |
   | ---------------- | ------------------------------------------------------------ |
   | Subscription     | Select your subscription.                                    |
   | Resource group   | Select the resource group ContosoResourceGroup               |
   | Name             | Enter a unique Name for your web app. This example uses WebAppContoso-1. |
   | Publish          | Select **Code**.                                             |
   | Runtime stack    | Select **.NET 8 (LTS)**.                                     |
   | Operating System | Select **Windows**.                                          |
   | Region           | Select **Central US**.                                       |
   | Windows Plan     | Select **Create new** and enter myAppServicePlanCentralUS in the text box. |
   | Pricing Plan    | Select **Standard S1 100 total ACU, 1.75 GB memory**.        |

1. Select **Review + create**, review the Summary, and then select **Create**.
   ‎It might take several minutes for the deployment to complete.

1. Create a second web app. On the Azure Portal home page, search  **WebApp**.

1. Select **+ Create** to create a Web App.

1. On the Create Web App page, on the **Basics** tab, enter or select the following information.

   | **Setting**      | **Value**                                                    |
   | ---------------- | ------------------------------------------------------------ |
   | Subscription     | Select your subscription.                                    |
   | Resource group   | Select the resource group ContosoResourceGroup               |
   | Name             | Enter a unique Name for your web app. This example uses WebAppContoso-2. |
   | Publish          | Select **Code**.                                             |
   | Runtime stack    | Select **.NET 8 (LTS)**.                                     |
   | Operating System | Select **Windows**.                                          |
   | Region           | Select **East US**.                                          |
   | Windows Plan     | Select **Create new** and enter myAppServicePlanEastUS in the text box. |
   | Pricing Plan     | Select **Standard S1 100 total ACU, 1.75 GB memory**.        |

1. Select **Review + create**, review the Summary, and then select **Create**.
   ‎It might take several minutes for the deployment to complete.

   >**Note**: If you receive a deployment error, read the notification carefully. If the error involves the region availability due to quotas, try changing to another region. 

## Task 2: Create a Front Door for your application

Configure Azure Front Door to direct user traffic based on lowest latency between the two web apps servers. To begin, add a frontend host for Azure Front Door.

1. On any Azure Portal page, in **Search resources, services and docs (G+/)**, Search for Front Door and CDN profiles, and then select **Front Door and CDN profiles**.

1. Select **Create front door and CDN profiles**. On the Compare offerings page, select **Quick create**. Then select **Continue to create a Front Door**.

1. On the Basics tab, enter or select the following information.

   | **Setting**             | **Value**                                    |
   | ----------------------- | -------------------------------------------- |
   | Subscription            | Select your subscription.                    |
   | Resource group          | Select ContosoResourceGroup                  |
   | Resource group location | Accept default setting                       |
   | Name                    | Enter a unique name in this subscription like FrontDoor(yourinitials)   |
   | Tier                    | Standard   |
   | Endpoint Name           | FDendpoint   |
   | Origin Type             | App Service|
   | Origin host name        | The name of the web app you previously deployed |

1. Select **Review and Create**, and then select **Create**.

1. Wait for the resource to deploy, and then select **Go to resource**.

1. On the Front Door resource in the Overview blade, locate the **Origin Groups**, select the origin group created

1. To update the origin group select the name **default-origin-group** from the list. Select **Add an origin** and add the second Web App. Select Add and then select Update.

## Task 3: View Azure Front Door in action

Once you create a Front Door, it takes a few minutes for the configuration to be deployed globally. Once complete, access the frontend host you created.

1. On the Front Door resource in the Overview blade, locate the endpoint hostname that is created for your endpoint. This should be fdendpoint followed by a hyphen and a random string. For example, **fdendpoint-fxa8c8hddhhgcrb9.z01.azurefd.net**. **Copy** this FQDN.

1. In a new browser tab, navigate to the Front Door endpoint FQDN. The default App Service page will be displayed.
   ![Browser showing App Service information page](../media/app-service-info-page.png)

1. To test instant global failover in action, try the following steps:

1. Switch to the Azure portal, search for and select **App services**.

1. Select one of your web apps, then select **Stop**, and then select **Yes** to verify.

   ![Azure Portal showing stopped Web App](../media/stop-web-app.png)

1. Switch back to your browser and select Refresh. You should see the same information page.

    **There may be a delay while the web app stops. If you get an error page in your browser, refresh the page**.

1. Switch back to the Azure Portal, locate the other web app, and stop it.

1. Switch back to your browser and select Refresh. This time, you should see an error message.

   ![Browser showing App Service error page](../media/web-apps-both-stopped.png)

   Congratulations! You have configured and tested an Azure Front Door.

## Clean up resources

   >**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. On the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell

   Remove-AzResourceGroup -Name 'ContosoResourceGroup' -Force -AsJob

   ```

   >**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

## Extend your learning with Copilot

Copilot can assist you in learning how to use the Azure scripting tools. Copilot can also assist in areas not covered in the lab or where you need more information. Open an Edge browser and choose Copilot (top right) or navigate to *copilot.microsoft.com*. Take a few minutes to try these prompts.
+ What are the differences between Azure Application Gateway and Azure Front Door? Provide examples where I would use each product.
+ Provide a checklist of things to do when configuring Azure Front Door.
+ What is an origin in Azure Front Door and how is it different from an endpoint?


## Learn more with self-paced training

+ [Introduction to Azure Front Door](https://learn.microsoft.com/training/modules/intro-to-azure-front-door/). In this module, you learn how Azure Front Door can protect your applications.
+ [Load balance your web service traffic with Front Door](https://learn.microsoft.com/training/modules/create-first-azure-front-door/). In this module, you learn to create and configure Azure Front Door. 

## Key takeaways

Congratulations on completing the lab. Here are the main takeaways for this lab. 
+ Azure Front Door is a cloud-based service that delivers your applications anywhere across the globe. 
+ Azure Front Door uses layer 7 load balancing to distribute traffic across multiple regions and endpoints.
+ Azure Front Door supports different traffic routing methods to determine how your HTTP/HTTPS traffic is distributed. The routing methods are: latency, priority, weighted, and session affinity. 
