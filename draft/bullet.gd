extends Area3D



var look_position = null
var direction = null
var speed = 1  # In m/s, at least i try
var damage = 1
#var damage


# Called when the node enters the scene tree for the first time.
func _ready():
	$Base_Bullet.look_at(look_position, Vector3.UP)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= (direction * delta) * speed
	


func set_pos(bod):
	direction = position - bod.position
	look_position = bod.position

func set_speed(s : float):
	speed = s


func _on_body_entered(body):
	#print("floor_stop_on_slope" in body)
	if "rs_health" in body:
		body.rs_health.health -= damage
	
	
	queue_free()
