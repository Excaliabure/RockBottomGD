extends RigidBody3D

var gravity = -0.098
var terminal_velocity : float = 53.0
var thrust = 10.0
@export var scalar : float = 10

var roll = 0.0
var pitch = 0.0
var yaw = 0.0
var thrust_vec : Vector3 = Vector3.ZERO


var wasd_mode = true
var speed = 0.1
var input : Vector3 = Vector3.ZERO
# Called every physics frame. 'delta' is the elapsed time since the previous physics frame.
func _physics_process(delta):
	
	if wasd_mode:
		gravity_scale = 0
		
		input = Vector3(Input.get_axis("ui_a","ui_d"), Input.get_axis("ui_left_ctrl","ui_jump"), Input.get_axis("ui_w","ui_s")) * 0.1
		
		position += input
		
	else:
		gravity_scale = 1
		thrust_vec = transform.basis.y * Input.get_axis("joy_left_down", "joy_left_up") * thrust
		angular_velocity *= 0.96
		
		roll = Input.get_axis("joy_left_right", "joy_left_left") * delta * scalar
		pitch = Input.get_axis("joy_right_up", "joy_right_down") * delta * scalar
		yaw = Input.get_axis("joy_right_left", "joy_right_right") * delta * scalar

		
		
		# Apply rotation based on input
		transform = transform.rotated_local(Vector3.UP, roll)
		transform = transform.rotated_local(Vector3.RIGHT, pitch)
		transform = transform.rotated_local(Vector3.FORWARD, yaw)
		
		print(pitch,roll,yaw)
		# Apply thrust
		apply_central_force(thrust_vec)
		
	#
func _process(delta):
	if Input.is_action_just_pressed("joypad_a"):
		position = Vector3(0.0,2.0,0.0)
		linear_velocity = Vector3(0.0,0.0,0.0)
		rotation = Vector3.ZERO
		transform.basis.x = Vector3(1.0,0.0,0.0)
		transform.basis.y = Vector3(0,1,0)
		transform.basis.z = Vector3(0,0,1)
		roll = 0.0
		pitch = 0.0
		yaw = 0.0
		
	if Input.is_action_just_pressed("f"):
		
		wasd_mode = wasd_mode == false
		linear_velocity = Vector3(0.0,0.0,0.0)
		rotation = Vector3.ZERO
		transform.basis.x = Vector3(1.0,0.0,0.0)
		transform.basis.y = Vector3(0,1,0)
		transform.basis.z = Vector3(0,0,1)
		
		
