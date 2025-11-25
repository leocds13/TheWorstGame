extends Node2D

@onready var path_2d: Path2D = %Path2D
@onready var wave_start_timer: Timer = $WaveStartTimer

const ENEMY = preload("uid://b08w1hrdrym13")

var wave_count = 0
var enemies: Array[PathFollow2D] = []
var level_speed = 300

func _physics_process(delta: float) -> void:
	for enemy in enemies:
		enemy.progress += level_speed * delta

func spawn_enemy():
	var new_enemy := PathFollow2D.new()
	new_enemy.add_child(ENEMY.instantiate())
	path_2d.add_child(new_enemy)
	enemies.append(new_enemy)

func spawn_wave():
	for i in wave_count * 5:
		spawn_enemy()
		await get_tree().create_timer(1.0).timeout

func _on_wave_start_timer_timeout() -> void:
	wave_count += 1
	spawn_wave.call_deferred()
	if wave_count < 2:
		wave_start_timer.start(wave_count * 10)

func _on_end_path_body_entered(body: Node2D) -> void:
	enemies.erase(body.get_parent())
	body.queue_free()
