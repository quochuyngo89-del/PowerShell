Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline 

Set-ExecutionPolicy RemoteSigned -Force
Install-Module ExchangeOnlineManagement -Force
Install-Module MSOnline -Force

Connect-ExchangeOnline -UserPrincipalName hpg-admin-hn@hpgroupllc.com
Connect-ExchangeOnline -ExchangeEnvironmentName O365USGovGCCHigh -UserPrincipalName hpg-admin-hn@hpgroupllc.com

#to find whose mailbox the user has access to
Get-Mailbox | % { Get-MailboxFolderPermission (($_.PrimarySmtpAddress.ToString())+”:\Calendar”) -User mohammed.jamal -ErrorAction SilentlyContinue} | select Identity,User,AccessRights

#get calendar permission from a specific user
Get-MailboxFolderPermission -Identity natalie.youch@reverba.com:\calendar

#message trace detail to the reciepient with message id
Get-MessageTraceDetail -MessageTraceId 3193be7f-8c02-4b28-fc31-08dd89095da1 -RecipientAddress peopleops@reverba.com

#get message trace detail
Get-MessageTrace -MessageTraceId 3193be7f-8c02-4b28-fc31-08dd89095da1 -SenderAddress automation@instascreen.net -StartDate 05/01/2025 -EndDate 05/02/2025 | Get-MessageTraceDetail

#get message trace
Get-MessageTrace -SenderAddress automation@instascreen.net -StartDate 05/01/2025 -EndDate 05/02/2025

#add delegate access to mailbox or shared mailbox
Add-MailboxPermission -Identity accounting@reverba.com -User ody.chalkidis@reverba.com -AccessRights FullAccess -InheritanceType All

#add delegate access to mailbox or shared mailbox without automapping
Add-MailboxPermission -Identity "Jeroen Cool" -User "Mark Steele" -AccessRights FullAccess -InheritanceType All -AutoMapping $false

#add user to a distro group
Add-DistributionGroupMember -Identity HPG-Admin-RG@hpgroupllc.com -Member ashwaq.ahmed@reverba.com

#removes Jan Dryml from the distribution group named Technical Support.
Remove-DistributionGroupMember -Identity NNINeuroHealth@reverba.com -Member wardha.wardha@reverba.com

#set Calendar access without notifying the owner. 
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User ed@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate -SendNotificationToUser $false

$Username = "kimberly.mark@reverba.com" # Replace with the user's email
$DistributionGroupAndUsers = foreach ($distro in (Get-DistributionGroup)) {
    $distro
    $distro.Name # Display the distribution group name
    Get-DistributionGroupMember -Identity $distro.Name | Where-Object {$_.EmailAddress -eq $Username} # Check if the user is a member
}

New-MailboxExportRequest -Mailbox charlotte.brown@reverba.com -FilePath "\\\\hpgplt\users\huy.ngo\charlotte.brown.pst" -IsArchive

#Let’s find out who is assigned to the role Mailbox Import Export. Make use of the Get-ManagementRoleAssignment cmdlet.
Get-ManagementRoleAssignment -role "Mailbox Import Export" -GetEffectiveUsers | ft -AutoSize
#Run the following cmdlet to give the admin account access to the role.
New-ManagementRoleAssignment -Role "Mailbox Import Export" -User "hpg-admin-hn" | ft -AutoSize

Get-ManagementRoleAssignment -Role "Mailbox Import Export" | Where-Object { $_.EffectiveUserName -like "hpg-admin-hn" } | Remove-managementRoleAssignment

Get-MailboxCalendarConfiguration -Identity kai | Format-List

Get-ADUser -Identity huy.ngo -Properties ProfilePath | Select-Object ProfilePath