extends Node

var newHub:String:
	set(value):
		newHub = value
		Levels = \
	["uid://crm2fqqeyg12f", #Tutorial - Storage Unit v2
	 "uid://jre5761gc8o1", #HubScene
	"uid://cdnij7booxhs4", #Apartments
	newHub,
	"uid://dlp1pmhousfx7", #Poolalt,
	newHub,
	"uid://cfcephiffwtxg", #RodriguezHouse
	newHub,
	"uid://d317crqywlqve", #IceHouseAlt
	newHub,
	"uid://c766m53y8wrk4", #FratHouseAlt
	newHub,
	"uid://bb3dywxtdya3a", #DollHouse
	"uid://rtrhhspwen6a" #TitleScreen
	]

## Stores a UID reference to the levels. It will always start from 0 when you
## play it from any scene since it is linear progression, so be aware
var Levels:Array[String] = \
	["uid://crm2fqqeyg12f", #Tutorial - Storage Unit v2
	 "uid://jre5761gc8o1", #HubScene
	"uid://cdnij7booxhs4", #Apartments
	newHub,
	"uid://dlp1pmhousfx7", #Poolalt,
	newHub,
	"uid://cfcephiffwtxg", #RodriguezHouse
	newHub,
	"uid://d317crqywlqve", #IceHouseAlt
	newHub,
	"uid://c766m53y8wrk4", #FratHouseAlt
	newHub,
	"uid://bb3dywxtdya3a", #DollHouse
	"uid://rtrhhspwen6a" #TitleScreen
	]
	
	# "uid://jre5761gc8o1", #HubScene
	
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

var previousItemList:Array = [
	
]
