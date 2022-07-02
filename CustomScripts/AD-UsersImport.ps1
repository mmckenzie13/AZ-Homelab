## AD User Import
mkdir C:\apps\
mkdir C:\apps\users
Set-Location C:\apps\users
$ADUsers = ("OU=Users,"+ $ADCore)

#Variables
# Variables
$ADBase = (get-addomain).DistinguishedName
$ADCore = ("OU=Organization,"+ $ADBase)

#Create Template File
"First Name,Last Name,Job Title,Office Phone,Email Address,Description,Organizational Unit,Enabled,Password" | Out-File -FilePath C:\apps\users\users.csv
"Jim,Smith,IT GUY,123-456-7890,jsmith@contoso.com,Imported by Powershell,OU,TRUE,Password!1234" | Out-File -FilePath C:\apps\users\users.csv -Append

Write-Host "You'll need to go to C:\apps\users\users.csv to update the csv file with your users. Make sure you click save."
Read-Host "Press Enter to continue the import..."

$CSV = Import-Csv -LiteralPath "C:\apps\users\users.csv"
foreach($user in $CSV) {
 
    # Password
    $SecurePassword = ConvertTo-SecureString "$($user.Password)" -AsPlainText -Force
 
    # Format their username
    $Username = "$($user.'First Name').$($user.'Last Name')"
    $Username = $Username.Replace(" ", "")
 
    # Create new user
    New-ADUser -Name "$($user.'First Name') $($user.'Last Name')" `
                -GivenName $user.'First Name' `
                -Surname $user.'Last Name' `
                -UserPrincipalName $Username `
                -SamAccountName $Username `
                -EmailAddress $user.'Email Address' `
                -Description $user.Description `
                -OfficePhone $user.'Office Phone' `
                -Path "$ADUsers" `
                -ChangePasswordAtLogon $true `
                -AccountPassword $SecurePassword `
                -Enabled ([System.Convert]::ToBoolean($Enabled))
# Notifications
Write-Host "Created $Username / $($user.'Email Address')"
}
