extends Node3D

class_name GameBox

@onready var visual_box : VisualBox = $VisualBox

@export var box_color = Shoe.ShoeType.ORANGE
#@export var box_type = "1"

@onready var game3d: Game3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game3d = get_node_or_null("../")
	if game3d is Game3D:
		self.game3d = game3d 
	
	visual_box.set_shape(box_color)
	visual_box.set_box_open(false)


func handle_new_shoe(shoe_type: Shoe.ShoeType):
	if game3d:
		var score = 30
		if box_color == shoe_type:
			score *= 4
		
		game3d.game.add_score(score)


func _on_body_entered(body):
	if body is FlyingShoe:
		# Save data from shoe
		var shoe_type = body.shoe_type
		
		body.queue_free()
		
		handle_new_shoe(shoe_type)
