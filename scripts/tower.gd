extends Node2D

var tower_fire_damage = 5
var tower_water_damage = 0
var tower_damage = 20

func _ready() -> void:
	global.tower = self
