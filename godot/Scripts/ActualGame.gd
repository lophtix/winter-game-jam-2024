extends Control

class_name ActualGame

@onready var ui : UI = $UI

var total_score: int = 0

var dropped_shoes : int = 0
var packed_shoes : int = 0
var paired_shoes : int = 0
var perfect_shoes : int = 0

func _ready():
	ui.set_score(0)
	
func update_score():
	total_score = (-10  * dropped_shoes + 
					20  * packed_shoes  + 
					40  * paired_shoes  + 
					100 * perfect_shoes)
	ui.set_score(total_score)

