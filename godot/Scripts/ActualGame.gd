extends Control

class_name ActualGame

@onready var ui : UI = $UI

var total_score: int = 0

func _ready():
	ui.set_score(0)
	
func add_score(score: int):
	total_score += score
	ui.set_score(total_score)

