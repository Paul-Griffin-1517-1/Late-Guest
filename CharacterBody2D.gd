extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_possessing := false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2

var bodies : Array[RigidBody2D]
func _physics_process(delta):
	# Add the gravity.
	#if Input.is_action_just_pressed("Float"):
		#direction.x = 0
		#direction.y = 0
	
	if Input.is_action_pressed("Float"):
		
		direction.y = Input.get_axis("Move Up", "Move Down")
		print(str(direction.y))
		if direction.y:
			velocity.y = lerpf(velocity.y,direction.y * SPEED,2*delta)
		#else:
			#velocity.y = move_toward(velocity.y, 0, SPEED)
		
		direction.x = Input.get_axis("Move Left", "Move Right")
		if direction.x:
			velocity.x = lerpf(velocity.x,direction.x * SPEED,2*delta)
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if not is_on_floor():
			direction.y += gravity * delta
		else:
			direction.y = 0
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			direction.y = JUMP_VELOCITY
		velocity.y = direction.y

		direction.x = Input.get_axis("Move Left", "Move Right")
		if direction.x:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
	if is_possessing:
		for i in bodies:
			pass#i.global_position = i.global_position + direction
			i.global_position += direction
			position += direction
			print(str(i.position))
	else:
		move_and_slide()
func _unhandled_input(event):
	if event.is_action_pressed("Possess"):
		is_possessing = !is_possessing
		print(str(is_possessing))
		for i in bodies:
			i.freeze = is_possessing


func _on_area_2d_body_entered(body):
	if body is RigidBody2D:
		bodies.append(body)


func _on_area_2d_body_exited(body):
	if bodies.has(body):
		bodies.erase(body)
