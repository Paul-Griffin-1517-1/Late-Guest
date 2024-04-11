extends Area2D

@export_file("*.tscn") var target_level := "res://Scenes/Rooms/room_base.tscn"
@export var target_index := 0



func _on_body_entered(body):
	print("ENTERED")
	SceneManager._current_room = target_level
