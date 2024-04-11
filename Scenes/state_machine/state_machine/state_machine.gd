@icon("./state_machine.svg")

## A State Machine for use with [code]StateMachineState[/code]s.
class_name StateMachine extends Node


## The current state.
@export var state: StateMachineState

## The previous state.
var previous_state: Node


func _ready() -> void:
	await owner.ready

	# Configure states
	for child in get_children():
		child.state_machine = self
		_disable_state(child)

	# Make sure there is a current state
	if not is_instance_valid(state):
		state = get_child(0)

	assert(is_instance_valid(state) and state is StateMachineState, "\"%s\" is not of type StateMachineState" % state)

	_enable_state(state)
	state._enter_state()


## Change state. [code]next_state[/code] can either be a [code]String[/code] name of a child node or a node reference. If the
## next state does not resolve to a [code]StateMachineState[/code] it will throw an error. If the next state is the same as the
## current state then no hooks or signals will be run.
func enter(next_state) -> void:
	if typeof(next_state) == TYPE_STRING:
		assert(has_node(next_state), "State machine is missing a \"%s\" state" % next_state)
		next_state = get_node(next_state)

	assert(next_state is StateMachineState, "\"%s\" is not of type StateMachineState" % next_state)

	if next_state == state:
		return

	previous_state = state
	previous_state._exit_state()
	previous_state.on_exited.emit()
	_disable_state(previous_state)

	state = next_state
	_enable_state(state)
	state._enter_state()
	state.on_entered.emit()


## Return the to previous state.
func enter_previous() -> void:
	enter(previous_state)


### Helpers


# Not to be called directly.
func _enable_state(target_state: StateMachineState) -> void:
	target_state.set_process(true)
	target_state.set_physics_process(true)
	target_state.set_process_input(true)
	target_state.set_process_unhandled_input(true)
	target_state.set_process_unhandled_key_input(true)


# Not to be called directly.
func _disable_state(target_state: StateMachineState) -> void:
	target_state.set_process(false)
	target_state.set_physics_process(false)
	target_state.set_process_input(false)
	target_state.set_process_unhandled_input(false)
	target_state.set_process_unhandled_key_input(false)
