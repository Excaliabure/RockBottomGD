extends RigidBody3D

@export var item : InvItem


var player = null

func _on_collect_area_body_entered(body: Node3D) -> void:
	
	if body.name == "Player":
		player = body
		player_collect()
		queue_free()
		
func player_collect():
	player.collect(item)
