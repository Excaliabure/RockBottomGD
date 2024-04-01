extends Resource

var T : Timer

@export var Duration = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	T = Timer.new()
	T.wait_time = 1
	T.one_shot = true
	#add_child(T)
	T.timeout.connect(_on_Timer_timeout)

	pass # Replace with function body.


func _on_Timer_timeout():
	print("")
