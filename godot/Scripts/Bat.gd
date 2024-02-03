extends Area2D

class_name Bat

var currentShoe: Shoe = null

func _ready():
	connect("body_entered", on_body_entered)
	connect("body_exited", on_body_exited)
	pass
	
func _input(event):
	var is_left_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	var is_whack_down = event is InputEventKey and event.is_action_pressed("Whack")
	if (is_left_click or is_whack_down) and currentShoe != null:
		currentShoe.whack(1, Vector2(0,0))
		pass

func _process(_delta):
	pass

func on_body_entered(body):
	if body is Shoe:
		currentShoe = body

func on_body_exited(body):
	if body == currentShoe:
		currentShoe = null
