extends Node2D

var shoeNode = preload("res://Scenes/Shoe.tscn")
@export var container: Node2D
@export var spawnTimeLow = 3.0
@export var spawnTimeHigh = 6.0
var spawnTimer = 0

func _ready():
	pass

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
		
	$Bat.global_position = get_global_mouse_position()

