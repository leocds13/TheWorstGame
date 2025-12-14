@tool
extends Resource
class_name DefenceAttr

@export
var name: String
@export
var texture: Texture2D
@export
var colorMod: Color
@export
var coll_shape: Shape2D
@export
var transform: Transform2D = Transform2D()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	
	if texture == null:
		warnings.push_back("texture is required")
	
	return warnings
