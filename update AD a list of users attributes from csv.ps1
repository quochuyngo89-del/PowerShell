#Import active directory module for running AD cmdlets
    Import-Module activedirectory

    #Store the data from the csv in the $ADUsers variable
    $ADUsers = Import-csv "C:\Users\Huy.Ngo\Documents\Book1.csv"

    #Loop through each row containing user details in the CSV file
    foreach ($User in $ADUsers) {
        $Username    = $User.SamAccountName
                    $title      = $User.Title
                    $Department = $User.Department
                    $State = $User.State
                    $Country = $User.Country
     Write-Warning "i get to here1"
    #Check to see if the user already exists in AD

    

                    if (Get-ADUser -Filter {SamAccountName -eq $Username})
                    {
    Write-Warning "i get to here2"
                                    Try{
                Write-Host "Checking user account for -->$Username<--" -ForegroundColor Green
                #User does exist then proceed to update the user account
                                        Get-ADUser  -Filter 'SamAccountName -eq $Username' | Set-ADUser -Title $title -Department $Department -State $State -Country $Country 
                Write-Host "Updated title -->$title<-- and Department -->$Department<-- and State -->$State<-- and Country -->$Country<-- for -->$Username<--" -ForegroundColor Green
                }
            Catch{
                Write-Warning "Error Updating account details for --->$Username<--"
                }
                    }
                    else
                    {
            #If user does exist, give a warning
                                    Write-Warning "A user account with username $Username does not exist in Active Directory."
        }
    }


