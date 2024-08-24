extends Area3D
var active = true
const id : int = 2

var bod = null
var attack_speed : float = 2.0# 2 bullets per second

var is_agro = false
var disable_initial_activation = false

var can_target = ["rs_health"]

var c = 0
var total_entered = 0


@onready var bullet = preload("res://draft/bullet.tscn")

func _ready():
	bod = $Default_Lookat
	

func _process(delta):
	# follows the player or looks at the defaut state
	
	if active:
		if is_agro:
			c += delta
		
		
		if c > 1 / attack_speed:
			
			c = 0
			var b = bullet.instantiate()
			b.position = $Turret_Head.global_position
			b.set_pos(bod)
			get_parent_node_3d().add_child(b)
			
			
			
		$Turret_Head.look_at(bod.position)
	

func _on_body_entered(body):
	# Tracks the position of the player
	total_entered += 1
	for i in can_target:
		if i in body:
			is_agro = true
			bod = body
	
func _on_body_exited(body):
	#Returns to default state
	bod = $Default_Lookat
	is_agro = false
