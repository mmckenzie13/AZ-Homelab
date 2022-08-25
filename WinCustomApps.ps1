## Download & Install Edge & Chrome MSI

## Make Working Directory
mkdir C:\apps
Set-Location C:\apps\

## Download Files
# Source URL
$url = "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/1023dc2c-05dd-4cf9-8ca0-b4b7f032be10/MicrosoftEdgeEnterpriseX64.msi"
# Destation file
$dest = "c:\apps\Edge.msi"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest


# Execute Install
cd C:\apps\
msiexec /package edge.msi /passive
