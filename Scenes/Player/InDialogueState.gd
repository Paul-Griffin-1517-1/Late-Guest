extends StateMachineState


func _ready():
	DialogueManager.dialogue_ended.connect(_on_d_ended)

func _on_d_ended(resource):
	state_machine.enter("NormalState")

func _physics_process(delta):
	if s.is_on_floor():
		s.velocity.y = 0
	else:
		s.velocity.y += s.gravity*delta
	s.velocity.x = 0
	s.move_and_slide()
