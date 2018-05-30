#Imports and global variables
$OSWmiObject = Get-WmiObject -Class Win32_OperatingSystem
$SystemWmiObject = Get-WmiObject -Class Win32_ComputerSystem
$ProcessorWmiObject = Get-WmiObject -Class Win32_Processor

#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\SysInfo.xaml"

#Event handlers
$frmSysInfo.add_Loaded({
	LoadOSName
	LoadOSVersion
	LoadOSManufacturer
	LoadSystemName
	LoadSystemManufacturer
	LoadSystemSKU
	LoadSystemModel
})

#Functions
Function LoadOSName {
	$txtOSName.Text = $OSWmiObject.Caption
}

Function LoadOSVersion {
	$txtOSVersion.Text = $OSWmiObject.Version
}

Function LoadOSManufacturer {
	$txtOSManufacturer.Text = $OSWmiObject.Manufacturer
}

Function LoadSystemName {
	$txtSystemName.Text = $SystemWmiObject.Name
}

Function LoadSystemManufacturer {
	$txtSystemManufacturer.Text = $SystemWmiObject.Manufacturer
}

Function LoadSystemSKU {
	$txtSystemSKU.Text = $SystemWmiObject.SystemSKUNumber
}

Function LoadSystemModel {
	$txtModel.Text = $SystemWmiObject.Model
}

#Show the GUI
$xamGUI.ShowDialog() | out-null