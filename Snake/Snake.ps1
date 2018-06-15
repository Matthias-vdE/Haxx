#region Imports and global variables

	#Set Debugging
	$DebugPreference = "Continue"

	#Load Windows.Forms. Needed to display Message Boxes
	[System.Reflection.Assembly]::LoadWithPartialName(“System.Windows.Forms”)

	 #Import the Snake class file.
	. "$PSScriptRoot\Snake_class.ps1"

	#Set the global GameSnake variable
	$Global:GameSnake

#endregion

#region Load the XML file

	& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\Snake.xaml"

#endregion

#region Event handlers

	$frmSnake.add_Loaded({
		NewGameSnake
	})

	$frmSnake.add_KeyDown({
		ChangeDirection($_.Key)
	})

#endregion

#region Functions

	Function NewGameSnake {
		$Global:GameSnake = [Snake]::new()
	}

	Function ChangeDirection {
		param(
			[string]$Key
		)
		Switch($Key) {
			"Up" {$Global:GameSnake.ChangeDirection([direction]::North)}
			"Down" {$Global:GameSnake.ChangeDirection([direction]::South)}
			"Left" {$Global:GameSnake.ChangeDirection([direction]::West)}
			"Right" {$Global:GameSnake.ChangeDirection([direction]::East)}			
		}
		Write-Debug $Global:GameSnake.Direction
	}

	Function Show-MessageBox {
		param (
			[string] $message,
			[string] $title
		)
		[Windows.Forms.MessageBox]::Show("$message", "$title", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Information)
	}

#endregion

#region Show the GUI

$xamGUI.ShowDialog() | out-null

#endregion