#Imports and global variables
[System.Reflection.Assembly]::LoadWithPartialName(“System.Windows.Forms”)
$Player1Score = 0
$Player2Score = 0
$PlayerTurn = 1
$SymbolsOnField = 0

#Load the XML file
& "$PSScriptRoot\loadDialog.ps1" -XamlPath "$PSScriptRoot\TicTacToe.xaml"

#Event handlers
$frmTicTacToe.add_Loaded({
})

$btnNewGame.add_Click({
	ClearField
})

$txtR1C1.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR1C2.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR1C3.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR2C1.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR2C2.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR2C3.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR3C1.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR3C2.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})
$txtR3C3.add_PreviewMouseLeftButtonUp({
	DrawSymbol($this)
})

$btnExit.add_Click({
	$frmTicTacToe.Close()
	Exit
})

#Functions
Function ClearField {
	$txtR1C1.Text = ""
	$txtR1C2.Text = ""
	$txtR1C3.Text = ""
	$txtR2C1.Text = ""
	$txtR2C2.Text = ""
	$txtR2C3.Text = ""
	$txtR3C1.Text = ""
	$txtR3C2.Text = ""
	$txtR3C3.Text = ""
}

Function DrawSymbol{
	param (
		$txtField
	)
	if ([string]::IsNullOrEmpty($txtField.Text)) {
		if ($PlayerTurn -eq 1) {
			$txtField.Text = "X"
			$global:PlayerTurn = 2
			$lblPlayer2.FontWeight = "UltraBold"
			$lblPlayer1.FontWeight = "Normal"
		} else {
			$txtField.Text = "O"
			$global:PlayerTurn = 1
			$lblPlayer1.FontWeight = "UltraBold"
			$lblPlayer2.FontWeight = "Normal"
		}
		$global:SymbolsOnField += 1
		if ($SymbolsOnField -eq 9) {
			Show-MessageBox "YOU'RE BOTH LOSER! -1 POINTS!" "OH NO"
			ResetAndIncreasePoints(0)
		}
		if (CheckWin) {
			if ($PlayerTurn -eq 2) {
				Show-MessageBox "YOU'RE WINNER" "Player 1"
				ResetAndIncreasePoints(1)
			} else {
				Show-MessageBox "YOU'RE WINNER" "Player 2"
				ResetAndIncreasePoints(2)
			}
		}
	}
}

Function ResetAndIncreasePoints {
	param(
		[int]$player
	)
	ClearField
	$Global:SymbolsOnField = 0
	if ($player -eq 1) {
		$Global:Player1Score += 1
		$lblScorePlayer1.Content = $Player1Score
	} elseif ($player -eq 2) {
		$Global:Player2Score += 1
		$lblScorePlayer2.Content = $Player2Score
	} else {
		$Global:Player1Score -= 1
		$Global:Player2Score -= 1
		$lblScorePlayer1.Content = $Player1Score
		$lblScorePlayer2.Content = $Player2Score
	}
}

Function CheckWin {
	if (CheckRows) { return $true }
	if (CheckColumns) { return $true }
	if (CheckDiagonal) { return $true }
	return $false
}

Function CheckRows {
	if (-not [string]::IsNullOrEmpty($txtR1C1.Text)) {
		if (($txtR1C1.Text -eq $txtR1C2.Text) -and ($txtR1C1.Text -eq $txtR1C3.Text) -and ($txtR1C1.Text -eq $txtR1C3.Text)) {return $true}
	}
	if (-not [string]::IsNullOrEmpty($txtR2C1.Text)) {
		if (($txtR2C1.Text -eq $txtR2C2.Text) -and ($txtR2C1.Text -eq $txtR2C3.Text) -and ($txtR2C1.Text -eq $txtR2C3.Text)) {return $true}
	}
	if (-not [string]::IsNullOrEmpty($txtR3C1.Text)) {
		if (($txtR3C1.Text -eq $txtR3C2.Text) -and ($txtR3C1.Text -eq $txtR3C3.Text) -and ($txtR3C1.Text -eq $txtR3C3.Text)) {return $true}
	}
	return $false
}

Function CheckColumns {
	if (-not [string]::IsNullOrEmpty($txtR1C1.Text)) {
		if (($txtR1C1.Text -eq $txtR2C1.Text) -and ($txtR1C1.Text -eq $txtR3C1.Text) -and ($txtR1C1.Text -eq $txtR3C1.Text)) {return $true}
	}
	if (-not [string]::IsNullOrEmpty($txtR1C2.Text)) {
		if (($txtR1C2.Text -eq $txtR2C2.Text) -and ($txtR1C2.Text -eq $txtR3C2.Text) -and ($txtR3C2.Text -eq $txtR3C2.Text)) {return $true}
	}
	if (-not [string]::IsNullOrEmpty($txtR1C3.Text)) {
		if (($txtR1C3.Text -eq $txtR2C3.Text) -and ($txtR1C3.Text -eq $txtR3C3.Text) -and ($txtR1C3.Text -eq $txtR3C3.Text)) {return $true}
	}
	return $false
}

Function CheckDiagonal {
	if (-not [string]::IsNullOrEmpty($txtR1C1.Text)) {
		if (($txtR1C1.Text -eq $txtR2C2.Text) -and ($txtR1C1.Text -eq $txtR3C3.Text) -and ($txtR2C2.Text -eq $txtR3C3.Text)) {return $true}
	}
	if (-not [string]::IsNullOrEmpty($txtR3C1.Text)) {
		if (($txtR3C1.Text -eq $txtR2C2.Text) -and ($txtR3C1.Text -eq $txtR1C3.Text) -and ($txtR2C2.Text -eq $txtR1C3.Text)) {return $true}
	}
}

Function Show-MessageBox {
	param (
		[string] $message,
		[string] $title
	)
	[Windows.Forms.MessageBox]::Show("$message", "$title", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Information)
}

#Show the GUI
$xamGUI.ShowDialog() | out-null