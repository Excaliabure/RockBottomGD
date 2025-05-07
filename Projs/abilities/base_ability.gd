extends Node
class_name Node_Base_Ability

@export var abilityMatrix : Array[int] = [0]


var shield = preload("res://Projs/abilities/shield.tscn")

var maxCasts : int = 10
var mode = null
"""
[Start letter, action action change action change 0]

0 - Movement
10 - Defense
20 - Attack
30 
"""




func _process(delta):
	var action = null
	for i in range(maxCasts):
		action = abilityMatrix[i]
		# Sets mode
		if action % 10 == 0:
			mode = action
		else:
			do_action(mode, action)
			
func do_action(mode, action):
	
	pass
	
func run():
	
