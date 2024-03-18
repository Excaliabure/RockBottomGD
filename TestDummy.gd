extends CharacterBody3D


# Properties
var speed = 100  # Adjust the speed of movement
var target_position = Vector3()  # Target position for the AI to move towards
var collision_distance = 50  # Distance to detect obstacles

@onready var  ray_cast = $RayStart

func _ready():
	pass  # Initialization code goes here

func _process(delta):
	## Calculate the movement vector towards the target position
	

	### If there's an obstacle, adjust movement vector
	#if obstacle_direction != Vector3.ZERO:
		#movement_vector = movement_vector.slide(obstacle_direction)
	transform.origin.x += 0.1;
	print(ray_cast.global_transform) 
	
	#transform.origin.x += 0.01;
	## Move the AI
	move_and_slide()

func check_for_obstacle():
	# Cast ray in the direction of movement to detect obstacles
	
	
	#
	## If an obstacle is detected, return the direction to slide away from
	
	pass
