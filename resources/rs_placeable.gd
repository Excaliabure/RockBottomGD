extends Resource
class_name rs_placable

var phantom_mesh = null
var objects = []
var object_position = []
var object_active = []
var object_hidden = []
var all_placed = true

@export var object_amount : int = 0

var cpos = 0
var phantom = null

func _ready():
	for i in range(object_amount):
		object_position.append(null)
		object_active.append(false)
		object_hidden.append(true)

	

func place(x : Vector3):
	if not all_placed:
		object_position[abs(cpos%object_amount)] = x
		cpos = (cpos + 1) % object_amount
		if null not in object_position:
			all_placed = true
		else:
			all_placed = false
		
		objects[cpos].position = object_position[cpos]
		objects[cpos].visible = true
		objects[cpos].active = true
		cpos += 1
	


func set_phantom(path):
	phantom = path
	phantom.visible = true

func set_objects(arr):
	objects = arr
	
func get_phantom():
	return phantom

func get_visibility():
	return object_hidden
	
func get_active():
	return object_active
