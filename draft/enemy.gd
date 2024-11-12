extends CharacterBody3D
var active = true

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var pos = null

func _ready():
	pass

func _physics_process(delta: float) -> void:
	if active:
	
		#if pos:
			#print(pos.transform)
			
			#var a = lerp(transform, pos.transform,1)
			#print(a)
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		move_and_slide()
		
		
	
func _unhandled_input(event: InputEvent) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if "drone" in body.name or "player" in body.name:
		pos = body
		
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if "drone" in body.name or "player" in body.name:
		pos = null
	
	pass # Replace with function body.
