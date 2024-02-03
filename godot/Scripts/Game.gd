extends Node2D

class_name Game

var engine : GameEngine

var shoeNode = preload("res://Scenes/Shoe.tscn")
@export var container : Node2D
@export var spawnTimeLow = 3.0
@export var spawnTimeHigh = 6.0
var spawnTimer = 0

func _ready():
	engine = get_node_or_null("..")

func handle_timeout():
	var shoeInstance = shoeNode.instantiate()
	var screenWidth = get_viewport_rect().size.x
	var xPosition = randf() * screenWidth
	shoeInstance.position.x = xPosition
	container.add_child(shoeInstance)

func _process(delta):
	spawnTimer -= delta
	if spawnTimer <= 0:
		spawnTimer = randf() * (spawnTimeHigh - spawnTimeLow) + spawnTimeLow
		handle_timeout()

func end_game():
	engine.end_game()
