#Script to find all installed application and software on remote server and export it in csv files 

$remoteServer = ""

$installedApp = Get-WmiObject -Class Win32_Product -ComputerName $remoteServer | Select-Object Name , Version ,InstallDate , Vendor

$installedApp | Export-Csv -Path "H:\Script\csv\csv2.csv"

Write-Host "Installed applications exported to CSV file."