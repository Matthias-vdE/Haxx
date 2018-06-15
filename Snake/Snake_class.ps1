Class Snake {
	# Properties
	[int]$Length
	[direction]$Direction
	[speed]$Speed

	# Constructor - Paramterless
	Snake () {
		$this.Length = 0
		$this.Direction = [direction]::Stationary
		$this.Speed =  [speed]::very_slow
	}

	# Constructor	
	Snake ([speed]$Speed) {
		$this.Length = 0
		$this.Direction = [direction]::Stationary
		$this.Speed = $Speed
	}

	# Change Direction of the Snake
	[Void] ChangeDirection([direction]$Direction) {
		$this.Direction = $Direction
	}

	# Change Speed of the Snake 
	[Void] ChangeSpeed([speed]$Speed) {
		$this.Speed = $Speed
	}

	# Change Length of the Snake
	[Void] ChangeLength([int]$Length) {
		$this.Length = $Length
	}

	# Increment Length by one
	[Void] IncrementLength() {
		$this.Length += 1
	}
}

Enum direction {
	Stationary = 0
	North = 1
	East = 2
	South = 3
	West = 4
}

Enum speed {
	very_slow = 0
	slow = 1
	normal = 2
	fast = 3
	ultra_fast = 4
}