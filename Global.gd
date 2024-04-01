extends Node


func win():
	get_tree().change_scene_to_file("res://victory.tscn")
func lose():
	get_tree().change_scene_to_file("res://defeat.tscn")
