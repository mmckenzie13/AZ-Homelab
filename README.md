# AZ-Homelab
## Azure Home Lab Builds for Testing

### **Build out your Resource Groups first and your VNET(s)** 
1. Open up Powershell and connect to your Azure subscription or use Cloud Shell
2. Run the **RG-NET-Setup.ps1**
3. **This will create the following Resource Groups**
* Core-RG (Domain Controllers)
* NET-RG (For VNET, FWs, VNGs)
* STORE-RG (For Storage)
* BACKUP-RG (For Recovery Vault / Azure Backup, ASR)
* DB-RG (For SQL, Databases, etc)
* VDI-RG (For AVD, M365 Virtual Desktop, Citrix Cloud, RDS)
* APPS-RG (For Application Servers)
* WEB-RG (For Web Servers, WebApps, Functions)
* DEV-RG (For Development)
4. **This will create the following VNET and Subnets** 
* VNET for CORE-VNET (10.100.0.0/16)
* Subnets for MainSubnet (10.100.0.0/24) and GatewaySubnet (10.100.3.0/27)
* VNET for vFortigate (10.0.0.0/16)
* Subnets for External (10.0.0.0/26), Protected (10.0.2.0/24), and Internal (10.0.1.0/24)
5. Confirm in the Azure Portal the creation / no errors while running the ps1

### **Build out your DCs (Domain Controllers)**
1. Open up Powershell and connect to your Azure subscription or use Cloud Shell
2. Run the **DC-WS2019-Setup.ps1**
* This will create the availibility set for the 2 Domain Controllers
* This will pull the **DC-WS2019-Template.json** and the **./ParameterFiles/DC01.json** and **DC02.json** files down to your local machine or Cloud Shell Storage
3. Confirm in the Azure Portal the creation / no errors while running the ps1

### **Build out your File & Print Servers (FP01)**
1. Open up Powershell and connect to your Azure subscription or use Cloud Shell
2. Run the **FP-WS2019-Setup.ps1**
* This will create the availibility set for the FP01 (File / Print Servers)
* This will pull the **FP-WS2019-Template.json** and the **./ParameterFiles/FP01.json** files down to your local machine or Cloud Shell Storage
3. Confirm in the Azure Portal the creation / no errors while running the ps1