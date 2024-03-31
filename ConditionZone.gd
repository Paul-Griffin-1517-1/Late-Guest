extends Area2D


@export_enum("WIN","LOSE") var zone_type = "WIN"



func _on_body_entered(body:CharacterBody2D):
	print("thing")
	if body.is_in_group("Player"):
		match zone_type:
			"WIN":
				Global.win()
			"LOSE":
				Global.lose()
