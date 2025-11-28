extends Path2D

@export var ene = preload("res://scenes/enemy.tscn")

var enemies_spawned = 0

func _on_timer_timeout() -> void:
	if 10 < enemies_spawned:
		var en = ene.instantiate()
		add_child(en)
		enemies_spawned += 1
