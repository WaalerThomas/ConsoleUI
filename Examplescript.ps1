$ErrorActionPreference = "Stop"

# Importerer LO ConsoleStatus
. ".\ConsoleUI.ps1"

function Create-MainMenu() {
    # Create a new menu
    $menu = New-Menu

    # Add MenuItems to the menu
    $menu.Add( (New-MenuItem -Key "1" -Name "Show form" -Data { Create-TestForm }) )
    $menu.Add( (New-MenuItem -Key "2" -Name "Run scriptblock check" -Data { Run-Check }) )
    $menu.Add( (New-MenuItem -Separator) )
    $menu.Add( (New-MenuItem -Key "0" -Name "Exit" -Data { exit }) )

    # Start menu
    Show-MenuExecute -Title "Test menu" -Menu $menu
}

function Create-TestForm() {
    # Create a Form-Object
    $form = New-Form

    # Create a Group and add two Radio-Objects to it
    $genderGroup = New-FormGroup -Id "genderGroup"
    $genderMale = New-FormRadio -Label "Male"
    $genderFemale = New-FormRadio -Label "Female"
    $genderGroup.Add($genderMale)
    $genderGroup.Add($genderFemale)

    # Add FormItems to the form
    $form.Add( (New-FormInput -Label "Firstname") )
    $form.Add( (New-FormInput -Label "Lastname ") )
    $form.Add( (New-FormSpacer) )
    $form.Add($genderGroup)
    $form.Add($genderMale)
    $form.Add($genderFemale)
    $form.Add( (New-FormSeparator) )
    $form.Add( (New-FormButton -Text "Send data" -Data { Create-MainMenu }) )

    # Start form
    Show-FormExecute -Title "Test Form" -Form $form
}

function Run-Check() {
    Write-Host ""
    
    CheckScriptBlock -Text "Counting to 100 000 000" -Data {
        for ($i = 0; $i -lt 100000000; $i++) {
        }
    }

    CheckScriptBlock -Text "Finding something cool" -Data {
        for ($i = 0; $i -lt 100000; $i++) {
        }
    }

    CheckScriptBlock -Text "Getting user informasjon" -Data {
        for ($i = 0; $i -lt 100000; $i++) {
            asdasdqw
        }
    }

    # Checking a scriptblock with a try catch
    Write-LineText -Text "Counting to 100 000 000"
    try {
        Write-LineState

        for ($i = 0; $i -lt 100000000; $i++) {
        }

        Write-LineState -Ok -Next
    } catch {
        Write-LineState -Fail -Next
        Write-Host "$($_.ToString())" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "Press enter to go back..."
    Read-Host
}

Create-MainMenu
