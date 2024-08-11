extends Area3D


var bod = null
var attack_speed = 1 # 2 bullets per second


var is_active = false
var disable_initial_activation = false

var c = 0
var total_entered = 0

@onready var bullet = preload("res://draft/bullet.tscn")

func _ready():
	bod = $Default_Lookat

func _process(delta):
	# follows the player or looks at the defaut state
	
	
	
	if is_active:
		c += delta
	
	
	if c > 1:
		
		c = 0
		var b = bullet.instantiate()
		b.position = $Turret_Head.global_position
		b.set_pos(bod)
		get_parent_node_3d().add_child(b)
		
		
		
	$Turret_Head.look_at(bod.position)
	

func _on_body_entered(body):
	# Tracks the position of the player
	total_entered += 1
	if "rs_health" in body:
		is_active = true
		bod = body
	
func _on_body_exited(body):
	#Returns to default state
	bod = $Default_Lookat
	is_active = false
