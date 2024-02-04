extends Control

class_name  GameEngine

@onready var menu : MainMenu = $Menu

@onready var gamePacked : PackedScene = preload("res://Scenes/Game.tscn")
var game : ActualGame = null

@onready var scorePacked : PackedScene = preload("res://Scenes/ScoreScreen.tscn")
var score_screen : ScoreScreen = null


# -----------------------------------------------------------------------------
# Switching scenes and such
# -----------------------------------------------------------------------------

func start_game():
	menu.hide()
	
	game = gamePacked.instantiate()
	add_child(game)


func end_game():
	if game:
		game.queue_free()
		game = null
	
	if score_screen:
		score_screen.queue_free()
		score_screen = null
	
	menu.show()


func end_game_and_go_to_scores():
	score_screen = scorePacked.instantiate()
	
	score_screen.update_with_points(game)
	
	game.queue_free()
	game = null
	
	add_child(score_screen)

