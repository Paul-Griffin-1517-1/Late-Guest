extends StateMachineState

func _enter_state():
	await get_tree().create_timer(1).timeout
	state_machine.enter("NormalState")
