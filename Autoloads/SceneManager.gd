extends Node

signal current_scene_changed
var _current_room :Variant="res://Scenes/Rooms/room_base.tscn":
	set(value):
		_current_room = value
		current_scene_changed.emit()
