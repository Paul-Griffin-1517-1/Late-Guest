extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button.grab_focus()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Level1.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Level2.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Level3.tscn")
