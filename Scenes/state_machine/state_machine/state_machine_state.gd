@icon("./state_machine_state.svg")


## A State Machine State for use within a [code]StateMachine[/code].
##
## Write your own states by extending [code]StateMachineState[/code].
## [br][br]
## Override [code]_ready[/code] to configure anything that only needs to run once.
## [br][br]
## Override [code]_enter_state[/code] and/or [code]_exit_state[/code] to run things that
## need to be set up or tore down as the state machine changes which state it is in.
## [br][br]
## Override [code]_process[/code] and [code]_physics_process[/code] to run things that are ongoing.
class_name StateMachineState extends Node


## Emitted just after entering this state
signal on_entered()
## Emitted just after exiting this state
signal on_exited()


## A reference to the parent state machine that gets populated when the state machine is initialised.
var state_machine: StateMachine = null

@onready var s :CharacterBody2D= get_owner()

## Called when the state machine switches to this state.
func _enter_state() -> void:
	pass


## Called just before the state machine switches away from this state.
func _exit_state() -> void:
	pass
