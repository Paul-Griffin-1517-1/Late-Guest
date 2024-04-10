extends Area2D

@export_file("*.dialogue") var _dialogue_resource := "res://Dialogue/DialogueFile.dialogue"
var dialogue_resource

var can_action := false

func _ready():
	dialogue_resource = load(_dialogue_resource)

func _unhandled_input(event):
	## TODO: This is temp code just to make sure the action() method works.
	if event.is_action_pressed("Jump"):
		can_action = true
		action()

func action():
	if can_action:
		can_action = false
		print("Talk")
		DialogueManager.show_dialogue_balloon_scene("res://Dialogue/balloon.tscn",dialogue_resource, name, [self])
