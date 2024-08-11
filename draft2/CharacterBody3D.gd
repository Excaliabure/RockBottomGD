extends CharacterBody3D

# Hyper parameters
const MAX_SPEED := 5.0
const JUMP_VELOCITY := 4.5
const ACCELERATION := 1
const MOUSE_SENSITIVITY :=  0.001



# onready vars
@onready var camera := $Camera3D
@onready var actionray := $Camera3D/ActionRay
@onready var Phantom_List := $Phantom_List



# ram vars
var current_speed = 0.0
var coin_counter = 0
var using_action_ray = false
var item := 0
var len_items := 0
var debug_stats := false
var stats := ""

# exported vars
@export var rs_health : Resource

# scene loading

# Note : to add more 
var obj_dict = {0 : preload("res://draft/placing/pokedots.tscn"),
				1 : preload("res://draft2/turret.tscn")}


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Phantom_list_hide()
	len_items = len(Phantom_List.get_children())
	$Control.hide()
	
	

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
		velocity.x = direction.x * MAX_SPEED
		velocity.z = direction.z * MAX_SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, MAX_SPEED)
		velocity.z = move_toward(velocity.z, 0, MAX_SPEED)
	
	
	if Input.is_action_just_pressed("c"):
		using_action_ray = (using_action_ray == false)
		
		Phantom_List.get_children()[item % len_items].visible = true
		# Instantiate object to spawn in
		# for now just cube 
	
	
	if using_action_ray:
		Phantom_List.global_position = actionray.get_collision_point()
		
		# A bit messy but gets the job done
		if Input.is_action_just_pressed("Left_Arrow"):
			Phantom_List.get_children()[item % len_items].visible = false
			Phantom_List.get_children()[(item + 1) % len_items].visible = true
			item += 1
			
		elif Input.is_action_just_pressed("Right_Arrow"):
			Phantom_List.get_children()[item % len_items].visible = false
			Phantom_List.get_children()[(item-1) % len_items].visible = true
			item -= 1
		
		if Input.is_action_just_pressed("ui_m1"):
			using_action_ray = false
			var object = obj_dict[item % len_items].instantiate()
			object.position = actionray.get_collision_point()
			
			get_node(".").get_parent().add_child(object)
			Phantom_list_hide()
			
			
			print("Instantiated")
	
	
	
	
	
	# Debug stuff
	if Input.is_action_just_pressed("p"):
		print(rs_health)
		#print(obj_dict[1])
	if Input.is_action_just_pressed("["):
		debug_stats = (debug_stats == false)
		
		if debug_stats:
			$Control.show()
		else:
			$Control.hide()
	
	$Control/Stats.text = get_stats()
		
	
	
	move_and_slide()


func Phantom_list_hide():
	for o in $Phantom_List.get_children():
		o.visible = false


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)



func _on_body_entered(body):
	pass # Replace with function body.

func get_stats():
	stats = ""
	stats += "Health : " + str(rs_health.health)
	return stats
	
