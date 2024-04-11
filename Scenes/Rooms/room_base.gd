extends Node2D
@onready var spawn_points_holder = $SpawnPointsHolder
@onready var exit_points_holder = $ExitPointsHolder
@onready var load_zones_holder = $LoadZonesHolder


var spawn_points : Array[Marker2D]
func _ready():
	for i in spawn_points_holder.get_children():
		if i is Marker2D:
			spawn_points.append(i)

