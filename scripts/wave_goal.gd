extends Node2D

func _ready() -> void:
	%Enemy_Detection.area_entered.connect(enemy_reached)

func enemy_reached(area: Area2D):
	if area:
		var rng_text = ["You powerless fool!", "If only there were towers to stop me!", "Muahahahaha!"]
		owner.lose_label.text = rng_text.pick_random()
