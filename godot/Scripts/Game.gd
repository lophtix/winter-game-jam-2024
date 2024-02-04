extends Node2D

class_name Game

@onready var engine : GameEngine = get_node_or_null("../../")
@onready var game3d : Game3D = get_node("../SubViewportContainer/SubViewport/Game3D")
@onready var ui : UI = get_node("../UI")

@export var shoes: Array[PackedScene]
@export var container : Node2D

var spawn
@export var spawnTimeLow = 3.0
@export var spawnTimeHigh = 6.0
var spawnTimer = 0

@export var gameTime = 30.0
@export var gameEndTime = 5.0

@export var marginPercent = 0.1

var timer : Timer

func _ready():
	spawn = true

	if gameTime >= 0:
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.wait_time = gameTime
		timer.timeout.connect(_on_time_up)
		timer.start()

func handle_timeout():
	var shoeNode = shoes[randi() % shoes.size()]
	var shoeInstance: Shoe = shoeNode.instantiate()
	var screenWidth = get_viewport_rect().size.x
	var xPosition = lerp(screenWidth * marginPercent, screenWidth * (1 - marginPercent), randf())
	shoeInstance.position.x = xPosition
	shoeInstance.game = self
	shoeInstance.rotation = (randf() * 2.0 - 1.0) * 4
	shoeInstance.angular_velocity = (randf() * 2.0 - 1.0) * 4
	container.add_child(shoeInstance)

func _process(delta):
	if timer != null:
		ui.set_timer(int(timer.time_left))
		
	if spawn:
		spawnTimer -= delta
		if spawnTimer <= 0:
			spawnTimer = randf() * (spawnTimeHigh - spawnTimeLow) + spawnTimeLow
			handle_timeout()
	else:
		if not container.get_children() and timer.is_stopped():
			timer.start()

func end_game():
	engine.end_game_and_go_to_scores()
	#engine.end_game()

func _on_time_up():
	if spawn:
		spawn = false
		timer.wait_time = gameEndTime
	else:
		end_game()
