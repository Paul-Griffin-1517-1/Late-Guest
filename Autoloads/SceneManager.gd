extends Node

var _current_room :Variant= "room_base":
	get:
		return load("res://Scenes/Rooms/"+_current_room+".tscn")

