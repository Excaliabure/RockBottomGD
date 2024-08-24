extends Node3D
var active = true
const id : int = 3

var rpos = null
var bpos = null

var red_active = false
var blue_active = false

@export var rs_placable : Resource


func _ready():
	bpos = $Blue.global_position
	rpos = $Red.global_position
	rs_placable.set_phantom($phantom)
	rs_placable.set_objects([$Red,$Blue])
	


func _on_blue_body_entered(body):
	if active:
		if "rs_health" in body:
			body.position = rpos
	active = false

func _on_red_body_entered(body):
	if active:
		if "rs_health" in body:
			body.position = bpos
	active = false

func _on_red_body_exited(body):
	active = true


func _on_blue_body_exited(body):
	active = true
