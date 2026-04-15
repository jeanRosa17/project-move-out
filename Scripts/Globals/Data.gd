extends Node

## Stores a UID reference to the levels.
const Levels:Array[String] = \
	["uid://crm2fqqeyg12f", #Tutorial - Storage Unit v2
	"uid://n31v0le4dxeh", #HubScene
	"uid://cdnij7booxhs4", #Apartments
	"uid://dlp1pmhousfx7", #poolAlt
	"uid://cduod51ifksbg", #RodriguezHouse
	"uid://djbnodthq7xxo", #IceHouseAlt
	"uid://bb3dywxtdya3a", #DollHouse
	"uid://n31v0le4dxeh", #HubScene
	"uid://c766m53y8wrk4" #FratHouseAlt
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
