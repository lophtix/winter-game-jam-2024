extends Node2D

var shoeNode = preload("res://Scenes/Shoe.tscn")
@export var container: Node2D
@export var spawnTimeLow = 3.0
@export var spawnTimeHigh = 6.0
var spawnTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnTimer -= delta
	if spawnTimer <= 0:
		spawnTimer = randf() * (spawnTimeHigh - spawnTimeLow) + spawnTimeLow
		var shoeInstance = shoeNode.instantiate()
		container.add_child(shoeInstance)
		pass
	pass
