
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"

Get-ADComputer HPG-2RPDQH2 -property *|select LastLogonDate
get-aduser alison.whitehead


CHKDSK C: /F /V /R /offlinescanandfix

DISM /Online /Cleanup-Image /StartComponentCleanup
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
SFC /scannow


$computerName = Read-Host "Enter Computer Name"
Get-WinEvent -ComputerName $computerName -FilterHashtable @{Logname='Security'; ID=4624} -MaxEvents 1 | 
    Select-Object -ExpandProperty Properties | 
    Where-Object { $_.Name -eq 'TargetUserName' } | 
    Select-Object @{Name='Last User Logged In';Expression={$_.Value}}

    Get-ADComputer HPG-17NP893 -property *|select LastLogonDate, *

    $computers = "HPG-9HHBQH2","HPG-BB4CVW3","HPG-C21TSG3","HPG-CJX1NH2","HPG-CZSZMF2","HPG-DT02NF2", "HPG-DVPZNF2","HPG-FHX2QW3","HPG-FLK0R74","HPG-FMK0R74","HPG-FPNWMF2","HPG-G396893","HPG-HCGTMF2","HPG-J27CQH2","HPG-SURFACE-HIG","HPG-SURFACE-JSC","REVERBA-SURF-CL","SURFACE3"


    $results = foreach ($computer in $computers) 
    {
    Get-ADComputer $computer -property *|select LastLogonDate
    }
    $results | Format-Table -AutoSize

    #find email, manager, name and title of a user
  get-aduser brian.mccoy -Properties mail,manager, SamAccountName,Title | select mail,manager, SamAccountName,Title

  
  #find group I am in
  Get-ADPrincipalGroupMembership huy.ngo | Select-Object name

  # this is a cmd line. find all the shared drives
  net use 

  #PS to get all the installed apps 
  Get-WmiObject  -Class win32_product


#PS to uninstall app by identify number
$application = Get-WmiObject -Class Win32_Product -Filter "IdentifyingNumber = '{58A3001D-B675-4D67-A5A1-0FA9F08CF7CA}'"
$application.Uninstall()




$UserList = Get-Content -Path "C:\Users\hpg-admin-hn\Documents\descript.txt"

$Results = foreach ($User in $UserList) {
    Get-ADUser -Identity $User -Properties SamAccountName, co, st | select SamAccountName, co, st  # Retrieve all properties for demonstration
}

$Results | Export-Csv -Path "C:\Users\hpg-admin-hn\Documents\descript output.csv" -NoTypeInformation

    cls