extends Area3D

class_name GameBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if self.has_overlapping_bodies():
        print("Collision detected!")
        
    pass
