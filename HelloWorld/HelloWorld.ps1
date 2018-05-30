#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\HelloWorld.xaml"

#Event handler
$btnHello.add_Click({
 $lblHello.Content = "Hello World"
})

#Show the GUI
$xamGUI.ShowDialog() | out-null