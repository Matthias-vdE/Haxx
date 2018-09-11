#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\PasswordTool.xaml"

#Import the PasswordToolbox module
Import-Module "$PSScriptRoot\PasswordToolbox.psm1"

#Event handlers
<#
$frmPasswordTool.add_Loaded({
	Generate-Password
})

$sldLength.add_ValueChanged({
	Generate-Password
})

$chkNumerical.add_Checked({
	Generate-Password
})

$chkNumerical.add_Unchecked({
	Generate-Password
})
#>

$btnGenerate.add_Click({
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
	switch($PasswordStrength) {
		0 {$txtStrength.Text = "SUPER WEAK!"; $txtStrength.Background = "Red"}
		1 {$txtStrength.Text = "WEAK"; $txtStrength.Background = "Red"}
		2 {$txtStrength.Text = "MEH"; $txtStrength.Background = "Orange"}
		3 {$txtStrength.Text = "COULD BE BETTER"; $txtStrength.Background = "Orange"}
		4 {$txtStrength.Text = "OK"; $txtStrength.Background = "Green"}
		5 {$txtStrength.Text = "GRRRRRREAT!"; $txtStrength.Background = "Green"}
	}
}

#Show the GUI
$xamGUI.ShowDialog() | out-null