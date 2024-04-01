extends Area2D


@export_enum("WIN","LOSE") var zone_type = "WIN"
@export_enum("ALL","WHEN_POSSESSED","WHEN_NORMAL") var condition = "ALL"


func _on_body_entered(body:CharacterBody2D):
	print("thing")
	if body.is_in_group("Player"):
		match condition:
			"ALL":
				destinator()
			"WHEN_POSSESSED":
				if body.is_possessing:
					destinator()
			"WHEN_NORMAL":
				if !body.is_possessing:
					destinator()

func destinator():
	match zone_type:
		"WIN":
			Global.win()
		"LOSE":
			Global.lose()
