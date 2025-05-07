extends CharacterBody3D

# Hyper parameters
var MAX_SPEED := 5.0
var JUMP_VELOCITY := 4.5
var ACCELERATION := 1
var MOUSE_SENSITIVITY :=  0.001

signal lasers

# onready vars
@onready var camera := $Camera3D
@onready var actionray := $Camera3D/ActionRay

@export var inv : Inv 
#@export var item : InvItem

# ram vars
var current_speed = 0.0
var extra_speed = 0.0
var coin_counter = 0
var using_action_ray = false
var len_items := 0
var debug_stats := false
var stats := ""
var object_placed = null



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	

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
	
		
		
	if Input.is_action_just_pressed("dot"):
		for o in $Area3D.get_overlapping_areas():
			if "active" in o:
				o.active = o.active == false
	
	
	
	
	# Debug stuff
	if Input.is_action_just_pressed("p"):
		pass
	
	

		$Control/Stats.text = get_stats()
	decay() # Used to decay 
	move_and_slide()



func _input(event):
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)


func get_stats():
	stats = ""
	stats += "Speed : " + str(velocity.length()).left(5) + "\n"
	#stats += "Health : " + str(rs_health.health) + "\n"
	
	return stats
	
func decay():
	if extra_speed > 0.01:
		extra_speed -= 0.01
		
		

func collect(item : InvItem):
	inv.insert(item)
