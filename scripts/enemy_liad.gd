extends AnimatedSprite2D

class_name enemy

@export var base_enemy_hp = 60
@export var base_enemy_speed = 0.05
@export var base_enemy_gold = 8

var damage_1 = 0
var damage_2 = 0
var damage_3 = 0
var final_damage = 0

@onready var path_follow_2d: PathFollow2D = $".."

func _compere():
	if damage_1 > damage_2:
		_compere3()
	else:
		_compere2()

func _compere2():
	if damage_2 > damage_3:
		final_damage = damage_2
		_take_final_damage()
	else:
		final_damage = damage_3
		_take_final_damage()

func _compere3():
	if damage_1 > damage_3:
		final_damage = damage_1
		_take_final_damage()
	else:
		final_damage = damage_1
		_take_final_damage()

func _take_final_damage():
	base_enemy_hp -= final_damage
	damage_1 = 0
	damage_2 = 0
	damage_3 = 0
	final_damage = 0

func _take_water_damage():
	damage_1 = global.tower.tower_water_damage * 0.5

func _take_fire_damage():
	damage_2 = global.tower.tower_fire_damage * 1.5

func _take_damage():
	damage_3 = global.tower.tower_damage * 1
	_compere()

func _process(delta: float) -> void:
	if 0 > base_enemy_hp:
		queue_free()
	path_follow_2d.progress_ratio += base_enemy_speed * delta
