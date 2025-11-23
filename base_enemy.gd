extends Node2D

var base_enemy_hp = 60
var base_enemy_speed = 50
var base_enemy_gold = 8



func take_damage(amount):
	base_enemy_hp -= amount
	if base_enemy_hp <= 0:
		die()

func die():
	gold += 8
