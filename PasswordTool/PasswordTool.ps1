#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\PasswordTool.xaml"

#Event handlers
$frmPasswordTool.add_Loaded({
	Generate-Password
})

$sldLength.add_ValueChanged({
	Generate-Password
})

#Functions
Function Generate-Password {
	$length = [int]$sldLength.Value
	$AlphaNumericalonly = $chkNumerical.IsChecked
	if ($AlphaNumericalonly -eq $true) {
		$Password = Get-RandomPassword -Length $length -AlphaNumericOnly
	} else {
		$Password = Get-RandomPassword -Length $length
	}
	$txtPassword.Text = $Password

	$PasswordStrength = Get-PasswordStrength $Password
	if ($PasswordStrength -eq 0) {
		$txtStrength.Text = "SUPER WEAK!"
		$txtStrength.Background = "Red"
	} elseif ($PasswordStrength -eq 1) {
		$txtStrength.Text = "WEAK"
		$txtStrength.Background = "Orange"
	} elseif ($PasswordStrength -eq 2) {
		$txtStrength.Text = "MEH"
		$txtStrength.Background = "YELLOW"
	} else {
		$txtStrength.Text = "OK"
		$txtStrength.Background = "GREEN"
	}
}

Function Get-RandomPassword {
    <#
    .SYNOPSIS
    Generates a random password.
    .DESCRIPTION
    Generates a random password, containg both letters, numbers and special characters.
    Based on the ASCII table ranging from characters 33 to 126. Basicly everything except special control characters.
    .EXAMPLE
    PS C:\> Get-RandomPassword -Length 15
    This generates a random password of 15 characters.
    .PARAMETER Length
    Length specifies the length of the generated password. Default is 10.
    .PARAMETER AlphaNumericOnly
    Switch parameter to specify whether the password generated should be alphanumerical only or not (no special characters).
    #>
    Param (
        [int]$Length = 10,
        [switch]$AlphaNumericOnly
    )

    if ($AlphaNumericOnly -eq $false) {
        $min = 33
        $max = 127
    }
    else {
        $min_numbers = 48
        $max_numbers = 58
        $min_uppercase = 65
        $max_uppercase = 91
        $min_lowercase = 97
        $max_lowercase = 123
    }

    $password = ""
    if ($AlphaNumericOnly -eq $true) {
        for ($counter = 1; $counter -le $length; $counter++) {
            $randomcharset = Get-Random -Min 1 -Max 4
            if ($randomcharset -eq 1) {
                $random = Get-Random -Minimum $min_numbers -Maximum $max_numbers
                $password += [char]$random   
            }
            elseif ($randomcharset -eq 2) {
                $random = Get-Random -Minimum $min_uppercase -Maximum $max_uppercase
                $password += [char]$random     
            }
            else {
                $random = Get-Random -Minimum $min_lowercase -Maximum $max_lowercase
                $password += [char]$random  
            }
        }
    }
    else {
        for ($counter = 1; $counter -le $length; $counter++) {
            $random = Get-Random -Minimum $min -Maximum $max
            $password += [char]$random
        }
    }
    return $password
}

Function Get-PasswordStrength {
    <#
    .SYNOPSIS
    Checks the strength of a password.
    .DESCRIPTION
    Checks the strength of a password. Solely based on the length.
    Passwords less than or equal to 3 characters long get a rating of 0.
    Passwords between 4 and 6 characters long get a rating of 1.
    Passwords between 7 and 9 characters long get a rating of 2.
    Passwords more than or equal to 10 characters long get a rating of 3.
    .EXAMPLE
    PS C:\> Get-PasswordStrength -Password 123
    This password will get a strength rating of 0.
    .EXAMPLE
    PS C:\> Get-PasswordStrength -Password abc1234
    This password will get a strength rating of 2.
    .PARAMETER Password
    Specify the password to check as a string.
    #>
    Param (
        [Parameter(Mandatory = $True)]
        [String]$Password
    )
    $Strength = 0
    if ($Password.Length -le 3) {
        $Strength = 0
    }
    elseif (($Password.Length -gt 3) -and ($Password.Length -le 6)) {
        $Strength = 1
    }
    elseif (($Password.Length -gt 6) -and ($Password.Length -le 9)) {
        $Strength = 2
    }
    else {
        $Strength = 3
    }
    return $Strength
}

#Show the GUI
$xamGUI.ShowDialog() | out-null