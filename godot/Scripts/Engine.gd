extends Control

class_name  GameEngine

@onready var menu : MainMenu = $Menu
@onready var game : Game = $Game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# -----------------------------------------------------------------------------
# Switching scenes and such
# -----------------------------------------------------------------------------

func start_game():
	menu.hide()
	game.show()
