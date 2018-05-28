#Load the XML file
.\loadDialog.ps1 -XamlPath "HelloWorld.xaml"

#Event handler
$btnHello.add_Click({
 $lblHello.Content = "Hello World"
})

#Show the GUI
$xamGUI.ShowDialog() | out-null