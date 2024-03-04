$remoteServer = ""
$remoteCredential = Get-Credential

$scriptBlock = {

$csvPath = "H:\Script\csv\csv.csv"

$EmailTo = @("ayush@gmail.com")
$emailsubject = "CSV file"
$EmailFrom = "ayush@gmail.com"
$SMTPServer = ""

$filteredFiles = Get-ChildItem -Path H:\ | Where-Object { (Get-Date) - $_.LastWriteTime -lt (New-TimeSpan -Days 5) } 
$filteredFiles | Export-Csv -Path $csvPath -NoTypeInformation 

$body1 = "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This is an automatic email for script execution. Kindly do not respond to this mail.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Hi Team,
Script: file_5days_old.ps1
Executed by: $env:USERNAME
Executed on: $env:COMPUTERNAME

Please find the attached  report.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

Send-MailMessage -To $EmailTo -From $EmailFrom -Subject $emailSubject -SmtpServer $SMTPServer -body $body1 -Attachments $csvPath

}

Invoke-Command -ComputerName $remoteServer -Credential $remoteCredential -ScriptBlock $scriptBlock
