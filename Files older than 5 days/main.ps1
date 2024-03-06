#taking the creadentials for remote server login
$remoteServer = ""
$remoteCredential = Get-Credential

#scriptblock will run the script in its scope on remote server
$scriptBlock = {

#define the path of csv
$csvPath = "H:\Script\csv\csv.csv" 

#email credentials for sending output csv to respesctive emails
$EmailTo = @("ayush@gmail.com")
$emailsubject = "CSV file"
$EmailFrom = "ayush@gmail.com"
$SMTPServer = ""

#using get-date to get curent date 
#using lastWriteTime to get to know when the file was last edited/modified
#New-Timespan is to compare and get the value/files which are less than 5 days
#Export-csv is used to export the output in csv format
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

#commands to send mail
Send-MailMessage -To $EmailTo -From $EmailFrom -Subject $emailSubject -SmtpServer $SMTPServer -body $body1 -Attachments $csvPath

}

#invoke-Command used to start remote server
Invoke-Command -ComputerName $remoteServer -Credential $remoteCredential -ScriptBlock $scriptBlock
