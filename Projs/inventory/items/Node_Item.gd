extends Node
class_name Node_Item


@export var item : InvItem


var player = null

func _on_collect_area_body_entered(body: Node3D) -> void:
	print(body)
	if body.name == "Player":
		player = body
		player_collect()
		get_parent().queue_free()
		
func player_collect():
	player.collect(item)
