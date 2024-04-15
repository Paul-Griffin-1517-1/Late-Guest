extends StateMachineState


func _physics_process(delta):
	if s.is_on_floor():
		s.velocity.y = 0
		if Input.is_action_just_pressed("Jump"):
			s.velocity.y = s.JUMP_VELOCITY
	else:
		s.velocity.y += s.gravity*delta
	s.velocity.x = s.direction.x*s.SPEED*delta
	
	
	
	s.move_and_slide()

func _unhandled_input(event):
	if event.is_action_pressed("Float"):
		state_machine.enter("FloatState")
	if event.is_action_pressed("Possess"):
		s.try_possess()

