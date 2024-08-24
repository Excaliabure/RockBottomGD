extends CharacterBody3D

# Hyper parameters
var MAX_SPEED := 5.0
var JUMP_VELOCITY := 4.5
var ACCELERATION := 1
var MOUSE_SENSITIVITY :=  0.001



# onready vars
@onready var camera := $Camera3D
@onready var actionray := $Camera3D/ActionRay
@onready var Phantom_List := $Phantom_List



# ram vars
var current_speed = 0.0
var extra_speed = 0.0
var coin_counter = 0
var using_action_ray = false
var item := 0
var len_items := 0
var debug_stats := false
var stats := ""
var object_placed = null


# exported vars
@export var rs_health : Resource

# scene loading

# Note : to add more 
var obj_dict = {0 : preload("res://draft/placing/pokedots.tscn"),
				1 : preload("res://draft2/turret.tscn"),
				2 : preload("res://draft/powerup.tscn"),
				3 : preload("res://draft/teleporter.tscn")}
				
				
var visible_obj_dict = null


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#Phantom_list_hide()
	len_items = len(obj_dict.keys())
	#$Control.hide()
	visible_obj_dict = {0 : $Phantom_List/pokedot,
						1 : $Phantom_List/turret,
						2 : $Phantom_List/powerup,
						3 : $Phantom_List/teleporter}
	
	

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_a", "ui_d", "ui_w", "ui_s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * (MAX_SPEED + extra_speed)
		velocity.z = direction.z * (MAX_SPEED + extra_speed)
		
	else:
		velocity.x = move_toward(velocity.x, 0, MAX_SPEED)
		velocity.z = move_toward(velocity.z, 0, MAX_SPEED)
	
	
	if Input.is_action_just_pressed("c"):
		using_action_ray = (using_action_ray == false)
		visible_obj_dict[abs(item % len_items)].visible = true
		# Instantiate object to spawn in
		# for now just cube 
	
	
	if using_action_ray:
		choosing()
		if Input.is_action_just_pressed("ui_m1"):
			var obj = obj_dict[item].instantiate()
			obj.global_position = actionray.get_collision_point()
			get_node('.').get_parent().add_child(obj)
			visible_obj_dict[item].visible = false
			using_action_ray = false
		
		
	if Input.is_action_just_pressed("dot"):
		for o in $Area3D.get_overlapping_areas():
			if "active" in o:
				o.active = o.active == false
	
	
	
	
	# Debug stuff
	if Input.is_action_just_pressed("p"):
		
		pass
		#print(obj_dict[1])
	if Input.is_action_just_pressed("["):
		debug_stats = (debug_stats == false)
		
		if debug_stats:
			$Control.show()
		else:
			$Control.hide()
	
	$Control/Stats.text = get_stats()

	decay() # Used to decay 
	move_and_slide()


var phantom_obj = null
var prev_phantom_obj = null
func choosing():
	
	if Input.is_action_just_pressed(("Left_Arrow")):
		visible_obj_dict[item].visible = false
		item = abs((item - 1) % len_items)
		visible_obj_dict[item].visible = true 
		
	elif Input.is_action_just_pressed(("Right_Arrow")):
		
		visible_obj_dict[item].visible = false
		item = abs((item + 1) % len_items)
		visible_obj_dict[item].visible = true
	$Phantom_List.global_position = actionray.get_collision_point()
	



func Phantom_list_hide():
	for o in $Phantom_List.get_children():
		o.visible = false


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)


func get_stats():
	stats = ""
	stats += "Speed : " + str(velocity.length()).left(5) + "\n"
	stats += "Health : " + str(rs_health.health) + "\n"
	
	
	return stats
	
func decay():
	if extra_speed > 0.01:
		extra_speed -= 0.01
		

func _on_body_entered(body):
	pass # Replace with function body.

		
