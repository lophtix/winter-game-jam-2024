extends Control

class_name  GameEngine

@onready var menu : MainMenu = $Menu
@onready var gamePacked : PackedScene = preload("res://Scenes/Game.tscn")
var game = null

# -----------------------------------------------------------------------------
# Switching scenes and such
# -----------------------------------------------------------------------------

func start_game():
	menu.hide()
	
	game = gamePacked.instantiate()
	add_child(game)

func end_game():
	game.queue_free()
	game = null
	
	menu.show()
