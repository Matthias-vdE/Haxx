#Imports and global variables

#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\TicTacToe.xaml"

#Event handlers
$frmTicTacToe.add_Loaded({
})

#Functions

#Show the GUI
$xamGUI.ShowDialog() | out-null