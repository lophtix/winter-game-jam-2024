extends Control

class_name ScoreScreen

func fill_with_boxes(game : ActualGame):
	$SubViewportContainer/SubViewport/ConveyerBelt.add_boxes_from_game(game)

func update_with_points(game : ActualGame):
	$Ui/Panel/MarginContainer/HBoxContainer2/Points.text = "%s points" % game.total_score
	
	$Ui/Panel/MarginContainer/HBoxContainer/Dropped/VBoxContainer/Amount.text = "%s x %s" % [game.dropped_shoes, game.dropped_shoes_points]
	$Ui/Panel/MarginContainer/HBoxContainer/Dropped/VBoxContainer/Points.text = "%s" % (game.dropped_shoes * game.dropped_shoes_points)
	
	$Ui/Panel/MarginContainer/HBoxContainer/Perfect/VBoxContainer/Amount.text = "%s x %s" % [game.perfect_shoes, game.perfect_shoes_points]
	$Ui/Panel/MarginContainer/HBoxContainer/Perfect/VBoxContainer/Points.text = "%s" % (game.perfect_shoes * game.perfect_shoes_points)
	
	$Ui/Panel/MarginContainer/HBoxContainer/Pair/VBoxContainer/Amount.text = "%s x %s" % [game.paired_shoes, game.paired_shoes_points]
	$Ui/Panel/MarginContainer/HBoxContainer/Pair/VBoxContainer/Points.text = "%s" % (game.paired_shoes * game.paired_shoes_points)
	
	$Ui/Panel/MarginContainer/HBoxContainer/Packed/VBoxContainer/Amount.text = "%s x %s" % [game.packed_shoes, game.packed_shoes_points]
	$Ui/Panel/MarginContainer/HBoxContainer/Packed/VBoxContainer/Points.text = "%s" % (game.packed_shoes * game.packed_shoes_points)


func end_game():
	$"../".end_game()
