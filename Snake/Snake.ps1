#Imports and global variables

#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\Snake.xaml"

#Event handlers
$frmSnake.add_Loaded({
})

$frmSnake.add_PreviewKeyDown({
	Write-Host "Break here"
})

#Functions

#Show the GUI
$xamGUI.ShowDialog() | out-null