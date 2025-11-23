extends PathFollow2D


var speed = 0.02

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio +=  delta * speed
