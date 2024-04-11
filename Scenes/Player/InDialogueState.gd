extends StateMachineState


func _ready():
	DialogueManager.dialogue_ended.connect(_on_d_ended)

func _on_d_ended(resource):
	state_machine.enter("NormalState")
