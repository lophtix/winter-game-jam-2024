extends Node2D

class_name Game

var engine : GameEngine

@export var shoes: Array[PackedScene]
@export var container : Node2D

var spawn
@export var spawnTimeLow = 3.0
@export var spawnTimeHigh = 6.0
var spawnTimer = 0

@export var gameTime = 30.0
@export var gameEndTime = 4.0

var timer : Timer

func _ready():
	engine = get_node_or_null("..")

	spawn = true

	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = gameTime
	timer.timeout.connect(_on_time_up)
	timer.start()

func handle_timeout():
	var shoeNode = shoes[randi() % shoes.size()]
	var shoeInstance = shoeNode.instantiate()
	var screenWidth = get_viewport_rect().size.x
	var xPosition = randf() * screenWidth
	shoeInstance.position.x = xPosition
	container.add_child(shoeInstance)

func _process(delta):
	if spawn:
		spawnTimer -= delta
		if spawnTimer <= 0:
			spawnTimer = randf() * (spawnTimeHigh - spawnTimeLow) + spawnTimeLow
			handle_timeout()
	else:
		if not container.get_children() and timer.is_stopped():
			timer.start()

func end_game():
	engine.end_game()

func _on_time_up():
	if spawn:
		spawn = false
		timer.wait_time = gameEndTime
	else:
		end_game()
