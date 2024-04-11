extends Node2D

@onready var room_holder = $RoomHolder
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneManager.current_scene_changed.connect(_on_changed)

func _on_changed():
	for i in room_holder.get_children():
		i.queue_free()
	room_holder.add_child(load(SceneManager._current_room).instantiate())
	player.state_machine.enter("LoadState")
	player.global_position = room_holder.get_child(0).spawn_points_holder.get_child(0).global_position
