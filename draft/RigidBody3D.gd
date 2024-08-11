extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Boop_body_enter(body):
	
	if body.is_in_group("wall"):
		queue_free()
	
