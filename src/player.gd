extends RigidBody3D


var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var ground_ray := RayCast3D

#const hand_dict := { "PortalGun" : "res://portalGun/portal_gun.tscn" }
const inhand := "res://guns/boop/boop_gun.tscn"

# boop gun : "res://guns/boop/boop_gun.tscn"
#portal gun : "res://portalGun/portal_gun.tscn"

var test_load := preload("res://portalGun/portalblue.tscn")

var Camera3 : Camera3D
var Camera1 : Camera3D

var gun = 0.0


var jump_force := 5.0
var is_jumping := false

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var action_ray := $TwistPivot/PitchPivot/Camera/ActionRay
@onready var head := $Head
@export var first_person := true
@export var Guntype := "PortalGun"


var temp = false


signal action_ray_pos
signal action_ray_normal


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	var head_pos = head.transform.origin
	
	if first_person:
		$TwistPivot.transform.origin = head_pos
		$TwistPivot/PitchPivot.transform.origin = head_pos
		$TwistPivot/PitchPivot/Camera.transform.origin = head_pos
	
	var handpos = $TwistPivot/PitchPivot/Inhand
	gun = preload(inhand).instantiate()
	#f.transform.origin = head_pos
	#
	handpos.add_child(gun)
	
	
		
func _process(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("ui_a","ui_d")
	input.z = Input.get_axis("ui_w","ui_s")
	
	apply_central_force(twist_pivot.basis * input * 1200.0 * delta)
	
	
	if Input.is_action_just_pressed("ui_jump") and not is_jumping:
		apply_impulse(Vector3(0, jump_force, 0))
		is_jumping = true
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if $GroundRay.is_colliding():
		is_jumping = false
		
	if Input.is_action_just_pressed("ui_m1"):
		
		
		gun.pass_point(action_ray.get_collision_point())
		gun.pass_normal(action_ray.get_collision_normal())
	
	
	
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x,
		deg_to_rad(-90),
		deg_to_rad(90)
	)
	twist_input = 0.0
	pitch_input = 0.0
	twist_pivot.rotation.z = 0.0
	
	
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

	

