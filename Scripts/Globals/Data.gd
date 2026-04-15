extends Node

## Stores a UID reference to the levels. It will always start from 0 when you
## play it from any scene since it is linear progression, so be aware
const Levels:Array[String] = \
	["uid://crm2fqqeyg12f", #Tutorial - Storage Unit v2
	"uid://jre5761gc8o1", #HubScene
	"uid://cdnij7booxhs4", #Apartments
	"uid://dlp1pmhousfx7", #poolAlt
	"uid://cduod51ifksbg", #RodriguezHouse
	"uid://d317crqywlqve", #IceHouseAlt
	"uid://cjree04v3e5qj", #DollHouse
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
