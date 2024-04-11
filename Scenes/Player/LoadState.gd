extends StateMachineState

func _enter_state():
	s.velocity = Vector2.ZERO
	await get_tree().create_timer(1).timeout
	state_machine.enter("NormalState")
