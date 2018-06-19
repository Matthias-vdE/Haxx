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
		$Global:GameSnake = $null
		$Global:GameSnake = [Snake]::new()
	}

	Function ChangeDirection {
		param(
			[string]$Key
		)
		Switch($Key) {
			"Up" {$Global:GameSnake.ChangeDirection([direction]::North); $Global:GameSnake.MoveSnake(); RedrawSnake}
			"Down" {$Global:GameSnake.ChangeDirection([direction]::South); $Global:GameSnake.MoveSnake(); RedrawSnake}
			"Left" {$Global:GameSnake.ChangeDirection([direction]::West); $Global:GameSnake.MoveSnake(); RedrawSnake}
			"Right" {$Global:GameSnake.ChangeDirection([direction]::East); $Global:GameSnake.MoveSnake(); RedrawSnake}
		}
	}

	Function RedrawSnake() {
		$txt00.Text = ""
		$txt01.Text = ""
		$txt02.Text = ""
		$txt10.Text = ""
		$txt11.Text = ""
		$txt12.Text = ""
		$txt20.Text = ""
		$txt21.Text = ""
		$txt22.Text = ""
		$currentpos = $Global:GameSnake.Location
		Write-Debug "Current Position: $currentpos"
		$field = "txt$($currentpos[0])$($currentpos[1])"
		
		$variables = Get-Variable -Name $field -ValueOnly
		$variables.Text = "X"
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