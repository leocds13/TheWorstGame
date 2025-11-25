extends Button

##Start, settings button to be linked after relevant level/ menus are made

func _ready() -> void:
	self.pressed.connect(Callable(self, "button_pressed").bind(name))

func button_pressed(type: String):
	match type:
		"Start": pass
			
		"Settings": pass
		
		"Exit": get_tree().quit()
	
