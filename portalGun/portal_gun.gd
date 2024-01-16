extends Node3D




@onready var ray := $RayCast3D
@onready var portal_red := preload("res://portalGun/portalred.tscn")
@onready var portal_blue := preload("res://portalGun/portalblue.tscn")
var portal_point_normal : Vector3
var portal_point :  Vector3


var portal_blue_instance = null
var portal_red_instance = null

var placed_blue = true

#var _x = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_m1"):
		place_portal()
		portal_fun()
	
	
	
func set_portal_point(x : Vector3):
	portal_point = x
	
func set_portal_point_normal(x : Vector3):
	portal_point_normal = x


func place_portal():
	
	var spawn_position = portal_point
	var spawn_rotation = portal_point_normal
	
	
	# Checks to see of both portals are placed
	if portal_blue_instance and portal_red_instance and placed_blue:
		portal_blue_instance.queue_free()
	
	elif portal_red_instance and portal_blue_instance and not placed_blue:
		portal_red_instance.queue_free()
	
	if placed_blue:
		portal_blue_instance = portal_blue.instantiate()
		portal_blue_instance.transform.origin = portal_point
		get_tree().root.add_child(portal_blue_instance)
		portal_blue_instance.look_at(portal_point + Vector3(0.001,0.001,0.001) - portal_point_normal)
	else:
		portal_red_instance = portal_red.instantiate()
		portal_red_instance.transform.origin = portal_point
		
		get_tree().root.add_child(portal_red_instance)
		portal_red_instance.look_at(portal_point + Vector3(0.001,0.001,0.001) - portal_point_normal)
	
	#placed_blue = not placed_blue



func portal_fun():
	
	print(portal_blue_instance.get_view())
	
	
	pass
	
	
	
