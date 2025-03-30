extends Control

var is_open = false

@onready var inv : Inv = preload("res://Projs/inventory/playerinv.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()


func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("e"):
		
		update_slots()
		#for i in range(min(inv.items.size(), slots.size())):
			#print(inv.items[i])
		if is_open:
			close()
		else:
			open()

func close():
	is_open = false
	visible = false

func open():
	is_open = true
	visible = true
