extends Node3D

var T = null
var start_pos




#var Info : TextEdit
@onready var Emission = preload("res://Anchor_emission.tscn")
@export var Duration = 4.0

var A 


func _teleport_seq(position0):
	
	""" position0 is transform """
	
	if T == null:
		print("Set Anchor : ", Duration, "s")
		
		A = Emission.instantiate()
		A.transform.origin = position0.origin
		start_pos = position0.origin
		
		T = Timer.new()
		T.wait_time = Duration
		T.one_shot = true
		
		add_child(T)
		get_tree().root.add_child(A)
		
		T.timeout.connect(_on_Timer_timeout)
		T.start()
		
		

func _on_Timer_timeout():
	get_parent().transform.origin = start_pos
	get_parent().linear_velocity = Vector3.ZERO
	T = null
	A.queue_free()
