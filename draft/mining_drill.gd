extends Node3D
var active = true

var c = 0

var tether = null
var tether_target = null

func _process(delta: float) -> void:
	if active:
		c += delta
		if c >= 1.0:
			
			pass
		pass
