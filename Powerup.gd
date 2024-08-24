extends Area3D
var active = true


const rotation_speed := 2

const amplitude = 0.01
const speed = 2

var t = 0
var used = false

func _process(delta):
	if active:
		t += delta
		$lightning.rotate_y(-deg_to_rad(rotation_speed))
		$lightning.position.y += sin(t*speed) * amplitude


func _on_body_entered(body):
	if active:
		if not used:
			if "rs_health" in body:
				body.rs_health.health += 10
				$lightning.visible = false
			if "extra_speed" in body:
				body.extra_speed += 5
				used = true
