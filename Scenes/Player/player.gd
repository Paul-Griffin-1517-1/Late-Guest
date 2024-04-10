extends CharacterBody2D

var phase_entry_point : Vector2
var exit_point : Area2D = null
#var possessable_object : Node2D
var possessable_objects_in_range : Array[Node2D]
var actionables_in_range : Area2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
