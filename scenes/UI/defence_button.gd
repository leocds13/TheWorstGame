@tool
extends Button

@export
var attributes: DefenceAttr

func _ready() -> void:
	icon = attributes.texture
	modulate = attributes.colorMod
	tooltip_text = attributes.name

func _on_pressed() -> void:
	if GlobalUi.defence_selected == attributes:
		GlobalUi.defence_selected = null
	else:
		GlobalUi.defence_selected = attributes
