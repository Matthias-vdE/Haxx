#Load the XML file
.\loadDialog.ps1 -XamlPath "SysInfo.xaml"

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
	$OSWmiObject = Get-WmiObject -Class Win32_OperatingSystem
	$OSCaption = $OSWmiObject.Caption
	$txtOSName.Text = $OSCaption
}

Function LoadOSVersion {
	$OSWmiObject = Get-WmiObject -Class Win32_OperatingSystem
	$OSVersion = $OSWmiObject.Version
	$txtOSVersion.Text = $OSVersion
}

Function LoadOSManufacturer {
	$OSWmiObject = Get-WmiObject -Class Win32_OperatingSystem
	$OSManufacturer = $OSWmiObject.Manufacturer
	$txtOSManufacturer.Text = $OSManufacturer
}

Function LoadSystemName {
	$SystemWmiObject = Get-WmiObject -Class Win32_ComputerSystem
	$SystemName = $SystemWmiObject.Name
	$txtSystemName.Text = $SystemName
}

Function LoadSystemManufacturer {
	$SystemWmiObject = Get-WmiObject -Class Win32_ComputerSystem
	$SystemManufacturer = $SystemWmiObject.Manufacturer
	$txtSystemManufacturer.Text = $SystemManufacturer
}

Function LoadSystemSKU {
	$SystemWmiObject = Get-WmiObject -Class Win32_ComputerSystem
	$SystemSKU = $SystemWmiObject.SystemSKUNumber
	$txtSystemSKU.Text = $SystemSKU
}

Function LoadSystemModel {
	$SystemWmiObject = Get-WmiObject -Class Win32_ComputerSystem
	$SystemModel = $SystemWmiObject.Model
	$txtModel.Text = $SystemModel
}

#Show the GUI
$xamGUI.ShowDialog() | out-null