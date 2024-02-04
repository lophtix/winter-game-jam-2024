extends Control

class_name ActualGame

@onready var ui : UI = $UI

var total_score: int = 0

const dropped_shoes_points : int = -1
var dropped_shoes : int = 0

const packed_shoes_points : int = 20
var packed_shoes : int = 0

const paired_shoes_points : int = 40
var paired_shoes : int = 0

const perfect_shoes_points : int = 40
var perfect_shoes : int = 0

func _ready():
	ui.set_score(0)
	
func update_score():
	total_score = (dropped_shoes_points  * dropped_shoes + 
					packed_shoes_points  * packed_shoes  + 
					paired_shoes_points  * paired_shoes  + 
					perfect_shoes_points * perfect_shoes)
	ui.set_score(total_score)

