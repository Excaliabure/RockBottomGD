extends CharacterBody3D


# Properties
var speed = 100  # Adjust the speed of movement
var target_position = Vector3()  # Target position for the AI to move towards
var collision_distance = 50  # Distance to detect obstacles

func _ready():
	pass  # Initialization code goes here

func _process(delta):
	## Calculate the movement vector towards the target position
	var movement_vector = (target_position - position).normalized()
#
	## Check for obstacles
	var obstacle_direction = check_for_obstacle()
#
	## If there's an obstacle, adjust movement vector
	if obstacle_direction != Vector3.ZERO:
		movement_vector = movement_vector.slide(obstacle_direction)
		
	#transform.origin.x += 0.01;
	## Move the AI
	move_and_slide()

func check_for_obstacle():
	# Cast ray in the direction of movement to detect obstacles
	var ray_cast = $RayCast3D
	ray_cast.cast_to = (target_position - position).normalized() * collision_distance
	ray_cast.force_raycast_update()
	
	# If an obstacle is detected, return the direction to slide away from
	if ray_cast.is_colliding():
		var collision_normal = ray_cast.get_collision_normal()
		return collision_normal
	else:
		return Vector3.ZERO  # No obstacle detected
