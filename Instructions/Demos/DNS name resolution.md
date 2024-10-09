---
demo:
    title: 'DNS name resolution'
    module: 'Module 01 - Introduction to Azure Virtual Networks'
---

✔ Always consider having students walk-through the demonstrations themselves. Also, consider the overlap with the formal labs and your best use of time. 

In this demonstration, you will explore Azure DNS.
Note: There is a DNS lab for the student.
Create a DNS zone
Access the Azure Portal.
Search for the DNS zones service.
On the Create DNS zone blade enter the following values, and Create the new DNS zone.
Name: contoso.internal.com 
Subscription: <your subscription>
Resource group: Select or create a resource group
Location: Select your Location
Wait for the DNS zone to be created.
You may need to Refresh the page.
Add a DNS record set
Select +Record Set.
Use the Type drop-down to view the different types of records.
Notice how the required information changes as you change record types.
Change the Type to A and enter these values.
Name: ARecord
IP Address: 1.2.3.4
Notice you can add other records.
Select OK to save your record.
Refresh the page to observe the new record set.
You will need the resource group name.
Optional - Use PowerShell to view DNS information
Open the Cloud Shell.
Get information about your DNS zones. Notice the name servers and number of record sets.
Get-AzDnsZone -Name "contoso.internal.com" -ResourceGroupName <resourcegroupname>
Get information about your DNS record set.
Get-AzDnsRecordSet -ResourceGroupName <resourcegroupname> -ZoneName contoso.internal.com
View your name servers
Access the Azure Portal and your DNS zone.
Review the Name Server information. There should be four name servers.
Open the Cloud Shell.
Use PowerShell to confirm your NS records.
# Retrieve the zone information
$zone = Get-AzDnsZone –Name contoso.internal.com –ResourceGroupName <resourcegroupname>
# Retrieve the name server records 
Get-AzDnsRecordSet –Name “@” –RecordType NS –Zone $zone
Test the resolution
Continue in the Cloud Shell.
Use a Name Server in your zone to review records.
nslookup arecord.contoso.internal.com <name server for the zone>
Nslookup should provide the IP address for the record.
Explore DNS metrics
Return to the Azure portal.
Select a DNS zone, and then select Metrics.
Use the Metrics drop-down to view the different metrics that are available.
Select Query Volume. If you have been using nslookup, there should be queries.
Use the Line Chart drop-down to observe other chart types, like Area Chart, Bar Chart, and Scatter Chart.
Note: For more information, Nslookup 

![image](https://github.com/user-attachments/assets/3e2d7306-fe57-42ed-930a-2df76fe3bdc3)
