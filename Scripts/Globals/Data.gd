extends Node

## Stores a UID reference to the levels.
const Levels:Array[String] = \
	["uid://crm2fqqeyg12f",
	"uid://cdnij7booxhs4",
	"uid://cduod51ifksbg",
	"uid://bb3dywxtdya3a",
	"uid://n31v0le4dxeh"
	]

var levelNum:int = 0

enum Direction {
	UP,
	LEFT,
	RIGHT,
	DOWN
}

enum Tetronimo {
	one_by_one,
	two_by_two,
	three_by_three,
	two_by_one,
	three_by_one,
	three_by_two,
	four_by_two,
	four_by_three
}
