extends CharacterBody2D

var phase_entry_point : Vector2
var exit_point : Area2D = null
#var possessable_object : Node2D
var possessable_objects_in_range : Array[Node2D]
var actionables_in_range : Array[Area2D]
	#set(value):
		#actionables_in_range = value
		#print(str(actionables_in_range))

const SPEED = 30000.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2
@onready var trigger_finder = $TriggerFinder
@onready var state_machine = $StateMachine



func _process(delta):
	direction.x = Input.get_axis("Move Left","Move Right")
	direction.y = Input.get_axis("Move Up","Move Down")
	#direction = direction.normalized()
	
	
	for i in actionables_in_range:
		if i == actionables_in_range.front():
			i.can_action = true
		else:
			i.can_action = false


func _on_trigger_finder_area_entered(area):
	actionables_in_range.append(area)
	


func _on_trigger_finder_area_exited(area):
	actionables_in_range.erase(area)

func _unhandled_input(event):
	if event.is_action_pressed("Interact") and actionables_in_range.size() > 0:
		actionables_in_range.front().action()
		state_machine.enter("InDialogueState")
