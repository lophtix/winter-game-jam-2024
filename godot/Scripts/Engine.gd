extends Control

class_name  GameEngine

@onready var menu : MainMenu = $Menu
@onready var gamePacked : PackedScene = preload("res://Scenes/Game.tscn")
var game = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_score(score: int):
	print(score)

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
