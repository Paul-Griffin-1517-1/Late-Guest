extends StateMachineState

func _physics_process(delta):
	#if s.is_on_floor():
		#s.velocity.y = 0
		#if Input.is_action_just_pressed("Jump"):
			#s.velocity.y = s.JUMP_VELOCITY
	#else:
	var lerp_speed :float= 3.0 * delta
	clampf(lerp_speed,0.0,1.0)
	s.velocity.y = lerpf(s.velocity.y,s.direction.y*s.SPEED*delta,lerp_speed)
	s.velocity.x = lerpf(s.velocity.x,s.direction.x*s.SPEED*delta,lerp_speed)
	#if s.velocity.length() > s.SPEED:
		#s.velocity.normalized()
	s.move_and_slide()

func _unhandled_input(event):
	if event.is_action_released("Float"):
		state_machine.enter("NormalState")

	if event.is_action_pressed("Possess"):
		s.try_possess()

func _exit_state():
	if s.is_inside_collision.size() > 0:
		s.global_position = s.entry_point
	s.set_collision_mask_value(1,true)
func _enter_state():
	s.set_collision_mask_value(1,false)
