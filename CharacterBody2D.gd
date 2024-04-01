extends CharacterBody2D

@onready var state_chart = $StateChart

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_possessing := false :
	set(value):
		is_possessing = value
		if is_possessing:
			state_chart.send_event("possessed")
		else:
			state_chart.send_event("not_possessed")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2
var bodies : Array[RigidBody2D]
var is_floating := false

func pp_float_movement(delta):
	is_floating = true
	set_collision_mask_value(1, false)
	direction.y = Input.get_axis("Move Up", "Move Down")
	velocity.y = lerpf(velocity.y,direction.y * SPEED,2*delta)
	if is_possessing:
		set_collision_mask_value(1, true)
		velocity.y += (gravity * delta)*.2
		if bodies.size() > 0:
			velocity.y *= bodies[0].mass
	direction.x = Input.get_axis("Move Left", "Move Right")
	velocity.x = lerpf(velocity.x,direction.x * SPEED,2*delta)
	pp_move_and_slide()

func pp_normal_movement(delta):
	is_floating = false
	
	set_collision_mask_value(1, true)
	if not is_on_floor():
		direction.y += gravity * delta
	else:
		direction.y = 0
	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		if is_possessing and bodies.size() > 0:
			#print(str(abs(bodies[0].linear_velocity.y)))
			if abs(bodies[0].linear_velocity.y) == 0:
				direction.y *= JUMP_VELOCITY
			#direction.y += (bodies[0].mass)
		else:
			if is_on_floor():
				direction.y = JUMP_VELOCITY
	if is_on_floor():
		can_float = true
	velocity.y = direction.y

	direction.x = Input.get_axis("Move Left", "Move Right")
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x:
		if velocity.x > 1:
			sprite.scale.x = -0.168
		else:
			sprite.scale.x = 0.168
	pp_move_and_slide()



func pp_move_and_slide():
	#if is_possessing:
		#for i in bodies:
			#i.global_position += direction
			#position += direction
#
		#sprite.visible = false
	#else:
	move_and_slide()
		#sprite.visible = true
func pp_possess(delta):
	#for i in bodies:
		#i.position = position
	pass


#
#func _physics_process(delta):
	#
	
func _unhandled_input(event):
	if event.is_action_pressed("Float"):
		if can_float:
			state_chart.send_event("float_pressed")
	elif event.is_action_released("Float"):
		state_chart.send_event("float_not_pressed")
		can_float = false

	if event.is_action_pressed("Possess") and bodies.size() > 0:
		is_possessing = !is_possessing
		for i in bodies:
			i.freeze = is_possessing


func _on_area_2d_area_entered(area):
	#if area:
	bodies.append(area.get_parent())


func _on_area_2d_area_exited(area):
	if bodies.has(area.get_parent()):
		bodies.erase(area.get_parent())
@onready var sprite := $Sprite2D

func _ready():
	sprite.play("default")

@onready var sprite_2d_2 := $Sprite2D2

func _on_normal_state_entered():
	sprite.visible = true
	sprite_2d_2.visible = false
	for i in bodies:
		i.global_position = global_position
		#global_position.y += 10
		#i.global_position.x += 12
		i.visible = true
		i.get_child(1).disabled = false


func _on_possessing_state_state_entered():
	for i in bodies:
		#i.global_position += direction
		#position += direction
		i.visible = false
		i.get_child(1).disabled = true
	sprite.visible = false
	sprite_2d_2.visible = true
	sprite_2d_2.texture = bodies[0].get_child(0).texture
	$GPUParticles2D.emitting = true

@onready var timer := $Timer

var can_float := true
func _on_floating_state_entered():
	timer.start()


func _on_timer_timeout():
	state_chart.send_event("float_not_pressed")
	can_float = false
