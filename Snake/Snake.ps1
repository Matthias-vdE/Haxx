#region Imports and global variables

	#Set Debugging
	$DebugPreference = "Continue"

	#Load Windows.Forms. Needed to display Message Boxes
	[System.Reflection.Assembly]::LoadWithPartialName(“System.Windows.Forms”)

	 #Import the Snake class file.
	. "$PSScriptRoot\Snake_class.ps1"

	#Set the global variables. GameSnake is the Snake object, Score is the score, ApplePosition is the position of the apple.
	$Global:GameSnake
	$Global:Score
	$Global:ApplePosition

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
		$Global:Score = 0
		$Global:GameSnake = $null
		$Global:GameSnake = [Snake]::new()
		GenerateApple
	}

	Function ChangeDirection {
		param(
			[string]$Key
		)
		Switch($Key) {
			"Up" {$Global:GameSnake.ChangeDirection([direction]::North); $Global:GameSnake.MoveSnake(); CollisionDetection; DrawSnake}
			"Down" {$Global:GameSnake.ChangeDirection([direction]::South); $Global:GameSnake.MoveSnake(); CollisionDetection; DrawSnake}
			"Left" {$Global:GameSnake.ChangeDirection([direction]::West); $Global:GameSnake.MoveSnake(); CollisionDetection; DrawSnake}
			"Right" {$Global:GameSnake.ChangeDirection([direction]::East); $Global:GameSnake.MoveSnake(); CollisionDetection; DrawSnake}
		}
	}

	Function DrawSnake() {
		ClearField
		$headposition = $Global:GameSnake.Location
		$headfield = "txt$($headposition[0])$($headposition[1])"
		$headtextfield = Get-Variable -Name $headfield -ValueOnly
		$headtextfield.Text = "X"

		$tailpositions = $Global:GameSnake.Tail
		foreach ($tailposition in $tailpositions) {
			$tailfield = "txt$($tailposition[0])$($tailposition[1])"
			$tailtextfield = Get-Variable -Name $tailfield -ValueOnly
			$tailtextfield.Text = "O"
		}
	}

	Function ClearField() {
		for ($i=1; $i -le 8; $i++) {
			for ($j=1; $j -le 8; $j++) {
				if (-not(($Global:ApplePosition[0] -eq $i) -and ($Global:ApplePosition[1] -eq $j))) {
					$field = "txt$($i)$($j)"
					$textfield = Get-Variable -Name $field -ValueOnly
					$textfield.Text = ""
				}
			}
		}
	}

	Function GetCurrentSnakeField() {
		$currentsnakepos = $Global:GameSnake.Location
		$currentfield = "txt$($currentsnakepos[0])$($currentsnakepos[1])"
		$currenttextfield = Get-Variable -Name $currentfield -ValueOnly
		return $currenttextfield
	}

	Function GetCurrentAppleField() {
		$currentapplepos = $Global:ApplePosition
		$currentfield = "txt$($currentapplepos[0])$($currentapplepos[1])"
		$currenttextfield = Get-Variable -Name $currentfield -ValueOnly
		return $currenttextfield
	}

	Function CollisionDetection() {
		$currenttextfield = GetCurrentSnakeField
		if ($currenttextfield.Text -eq "#") {
			Show-MessageBox "YOU HIT THE WALL!" "GAME OVER"
		}
		if ($currenttextfield.Text -eq "@") {
			Show-MessageBox "APPLE GET!" "WINRAR"
			$Global:Score += 1
			GenerateApple
		} if ($currenttextfield.Text -eq "O") {
			Show-MessageBox "YOU HIT YOUR OWN TAIL!" "GAME OVER"
		}
	}

	Function GenerateApple() {
		$x = Get-Random -Minimum 1 -Maximum 8
		$y = Get-Random -Minimum 1 -Maximum 8
		$applefield = "txt$($x)$($y)"
		$appletextfield = Get-Variable -Name $applefield -ValueOnly
		$currentsnakefield = GetCurrentSnakeField
		if ($appletextfield -eq $currentsnakefield) {
			GenerateApple
		}
		$appletextfield.Text = "@"
		$Global:ApplePosition = ($x,$y)
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