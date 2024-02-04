extends Node3D

class_name GameBox

@onready var visual_box : VisualBox = $VisualBox

@export var box_color = Shoe.ShoeType.ORANGE
#@export var box_type = "1"

@onready var game3d: Game3D

var last_shoe_type = null

func set_type(type: Shoe.ShoeType):
	box_color = type
	
	visual_box.set_shape(box_color)
	visual_box.set_box_open(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var maybe_game3d = get_node_or_null("../")
	if maybe_game3d is Game3D:
		game3d = maybe_game3d 
	
	set_type(box_color)

func handle_new_shoe(shoe_type: Shoe.ShoeType):
	if game3d:
		game3d.game.packed_shoes += 1
		if box_color == shoe_type:
			game3d.game.perfect_shoes += 1
		if last_shoe_type == null && last_shoe_type == shoe_type:
			game3d.game.paired_shoes += 1
		
		game3d.game.update_score()
		
		last_shoe_type = shoe_type


func _on_body_entered(body):
	if body is FlyingShoe:
		# Save data from shoe
		var shoe_type = body.shoe_type
		
		body.queue_free()
		
		handle_new_shoe(shoe_type)
