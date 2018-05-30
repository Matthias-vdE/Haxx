#Imports and global variables
$OSWmiObject = Get-WmiObject -Class Win32_OperatingSystem
$SystemWmiObject = Get-WmiObject -Class Win32_ComputerSystem
$ProcessorWmiObject = Get-WmiObject -Class Win32_Processor
$BiosWmiObject = Get-WmiObject -Class Win32_Bios

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
	LoadProcessor
	LoadBios
	LoadBiosManufacturer
	LoadPSVersion
	LoadIEVersion
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

Function LoadProcessor {
	$FullName = $ProcessorWmiObject.Name
	$Fullname = $FullName -replace "\(R\)", "" -replace "\(TM\)", ""
	$Split = $FullName -split "@"
	$ProcName = $Split[0].Trim()
	$txtProcessor.Text = $ProcName
}

Function LoadBios {
	$txtBios.Text = $BiosWmiObject.SMBIOSBIOSVersion
}

Function LoadBiosManufacturer {
	$txtBiosManufacturer.Text = $BiosWmiObject.Manufacturer
}

Function LoadPSVersion {
	$txtPowershellVersion.Text = $PSVersionTable.PSVersion
}

Function LoadIEVersion {
	$IEProperties = Get-Item "$env:ProgramFiles\Internet Explorer\iexplore.exe"
	$txtIEVersion.Text = $IEProperties.VersionInfo.ProductVersion
}

#Show the GUI
$xamGUI.ShowDialog() | out-null