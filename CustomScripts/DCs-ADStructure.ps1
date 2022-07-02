# Variables
$ADBase = (get-addomain).DistinguishedName
$ADCore = ("OU=Organization,"+ $ADBase)
$ADComputers = ("OU=Computers,"+ $ADCore)
$ADGroups = ("OU=Groups,"+ $ADCore)
$ADServers = ("OU=Servers,"+ $ADCore)
$ADUsers = ("OU=Users,"+ $ADCore)

#Creation of OUs
NEW-ADOrganizationalUnit “Organization” –path $ADBase

NEW-ADOrganizationalUnit “Computers” –path $ADCore
NEW-ADOrganizationalUnit “Disabled” –path $ADComputers
NEW-ADOrganizationalUnit “Sites” –path $ADComputers

NEW-ADOrganizationalUnit “Groups” –path $ADCore
NEW-ADOrganizationalUnit “Contacts” –path $ADGroups
NEW-ADOrganizationalUnit “Distribution Groups” –path $ADGroups
NEW-ADOrganizationalUnit “Icon Groups” –path $ADGroups
NEW-ADOrganizationalUnit “Printer Groups” –path $ADGroups
NEW-ADOrganizationalUnit “Security Groups” –path $ADGroups

NEW-ADOrganizationalUnit “Servers” –path $ADCore
NEW-ADOrganizationalUnit “VDI” –path $ADServers
NEW-ADOrganizationalUnit “FP” –path $ADServers
NEW-ADOrganizationalUnit “DB” –path $ADServers
NEW-ADOrganizationalUnit “WEB” –path $ADServers
NEW-ADOrganizationalUnit “APPS” –path $ADServers

NEW-ADOrganizationalUnit “Service Accounts” –path $ADCore

NEW-ADOrganizationalUnit “Users” –path $ADCore
NEW-ADOrganizationalUnit “Admin Accounts” –path $ADUsers
NEW-ADOrganizationalUnit “Departments” –path $ADUsers
NEW-ADOrganizationalUnit “Disabled” –path $ADUsers
NEW-ADOrganizationalUnit “Generic Accounts” –path $ADUsers
NEW-ADOrganizationalUnit “Vendors” –path $ADUsers

# Redirect Default Computers OU
redircmp $ADComputers