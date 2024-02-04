extends AnimatableBody2D

class_name Bat

var chargeMode = false
@onready var prevXPosition = global_position.x
@onready var initialRotation = rotation
@onready var initialScale = scale

@export var rotationScale: float
@export var maxVelocity: float

@export var batStrength: float = 1

var tiltRotation: float = 0.0
var pullbackRotation: float = 0.0

func _ready():
	pass

func _input(event):
	var is_left_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	var is_left_click_down = is_left_click and event.pressed
	var is_left_click_up = is_left_click and not event.pressed
	var is_whack_down = event is InputEventKey and event.is_action_pressed("Whack")
	var is_whack_up = event is InputEventKey and event.is_action_released("Whack")

	if is_left_click_down or is_whack_down:
		chargeMode = true
		$BatCollider1.disabled = true
		$BatCollider2.disabled = true
		$BatCollider3.disabled = true

	if chargeMode and (is_left_click_up or is_whack_up):
		chargeMode = false
		$BatCollider1.disabled = false
		$BatCollider2.disabled = false
		$BatCollider3.disabled = false
		var hit_something = false
		var bodies: Array[Node2D] = $WhackArea.get_overlapping_bodies()
		for body in bodies:
			if body is Shoe:
				hit_something = true
				body.whack(1/batStrength, Vector2(0,0))
		if hit_something:
			$BonkPlayer.play()
		else:
			$WooshPlayer.play()
			
func _physics_process(_delta):
	transform = Transform2D(
		initialRotation + pullbackRotation + tiltRotation, 
		lerp(global_position, get_global_mouse_position(), 0.4)
	)

func _process(_delta):
	var xVelocity = global_position.x - prevXPosition
	var ratio = clamp(xVelocity / maxVelocity, -1, 1)
	var angle = asin(ratio) * rotationScale
	tiltRotation = lerp(tiltRotation, angle, 0.3)
	prevXPosition = global_position.x

	if chargeMode:
		scale = lerp(scale, initialScale * 1.2, 0.1)
		pullbackRotation = lerp(pullbackRotation, PI / 64.0, 0.1)
	else:
		scale = initialScale
		pullbackRotation = 0
