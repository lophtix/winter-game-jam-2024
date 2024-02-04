extends Node3D

@onready var box_packed : PackedScene = load("res://Scenes/GameBox.tscn")  
@onready var score_box_packed : PackedScene = load("res://Scenes/ScoreBox.tscn")  

var boxes : Array[GameBox]

@export var spawnStart : Vector3
@export var spawnEnd : Vector3
@export var spawnHeight : float


# Called when the node enters the scene tree for the first time.
func _ready():
	if not boxes:
		for i in range(0,10):
			var box : GameBox = box_packed.instantiate()
			box.find_child("GameBox").box_color = Shoe.ShoeType.keys()[randi() % Shoe.ShoeType.size()]
			boxes.append(box_packed.instantiate())
	
	var spawnHeightStep = 0
	for box in boxes:
		box.position = lerp(spawnStart, spawnEnd, randf())
		box.position.y += spawnHeightStep
		spawnHeightStep += spawnHeight
		add_child(box)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
