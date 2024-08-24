extends Area3D
var active = true

const coin : int = 1
const ROTATION_SPEED := 2

const amplitude = 0.01
const speed = 2

var t = 0
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		rotate_y(deg_to_rad(ROTATION_SPEED))
		t += delta
		
		var wobble_method = sin(t*speed) * amplitude
		position.y += wobble_method
	

func _on_body_entered(body):
	queue_free()
	body.coin_counter += 1
