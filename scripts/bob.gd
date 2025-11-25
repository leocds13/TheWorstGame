extends PathFollow2D


var speed = 0.2

func _physics_process(delta: float) -> void:
	progress_ratio +=  delta * speed
