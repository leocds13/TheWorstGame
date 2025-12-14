@tool
extends Node2D
class_name Defence

@export
var attributes : DefenceAttr:
	set(value):
		if attributes != null:
			attributes.changed.disconnect(_update_with_attributes)
		attributes = value
		if attributes != null:
			attributes.changed.connect(_update_with_attributes)
		if is_node_ready():
			_update_with_attributes()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	_update_with_attributes()

func _update_with_attributes():
	if attributes == null:
		return
	
	sprite_2d.transform = attributes.transform
	sprite_2d.texture = attributes.texture
	modulate = attributes.colorMod
	collision_shape_2d.shape = attributes.coll_shape
