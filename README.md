# ConsoleUI
Script for building menus and status indication for own scripts

**Disclamer**: The script works for creating simple menus, forms and you can check status on scriptblocks. There is plenty of room for improvement. Copied a project from 2018. Not being worked on.

``` PowerShell
# Import ConsoleUI (Change path for you needs)
. ".\ConsoleUI"
```

## Menu
###### Creating a simple menu
``` PowerShell
# Create a new menu
$menu = New-Menu

# Add MenuItems to the menu
$menu.Add( (New-MenuItem -Key "1" -Name "Itemlist 1" -Data { functionName }) )
$menu.Add( (New-MenuItem -Key "2" -Name "Itemlist 2" -Data { Write-Host "Clicked list 2"; Read-Host }) )
$menu.Add( (New-MenuItem -Key "3" -Name "Itemlist 3") )

# Start menu
Show-MenuExecute -Title "Test menu" -Menu $menu
```

### Functions
``` PowerShell
New-Menu

# Args: null
# Returns: Menu-object
```
``` PowerShell
New-MenuItem -Key "1" -Name "Itemlist 1" -Data {}
# Separator
New-MenuItem -Separator

# Args: String: Key | String: Name | ScriptBlock: Data | Switch: Separator 
# Returns: null
```
``` PowerShell
Show-MenuExecute -Title "Menutitle" -Menu <MenuObject>

# Args: String: Menu | MenuItemList: Menu
# Returns: null
```

## Form
###### Creating a simple form
``` PowerShell
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
$form.Add( (New-FormButton -Text "Send data" -Data { }) )

# Start form
Show-FormExecute -Title "Test Form" -Form $form
```

## Consolestatus
###### 
``` PowerShell
# Checking a scriptblock with a function
CheckScriptBlock -Text "Counting to 100 000 000" -Data {
    for ($i = 0; $i -lt 100000000; $i++) {
    }
}
```
``` PowerShell
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
```
