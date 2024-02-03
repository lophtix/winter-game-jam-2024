extends Control

class_name MainMenu

@export var engine : GameEngine

@onready var main = $Main
@onready var credits = $Credits


# Called when the node enters the scene tree for the first time.
func _ready():
	show_main()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_game():
	engine.start_game()

func show_credits():
	main.hide()
	credits.show()

func show_main():
	main.show()
	credits.hide()
