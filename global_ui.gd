extends Node
class_name GlobalUI

signal defence_selected_changed
var defence_selected: DefenceAttr:
	set(val):
		defence_selected = val
		defence_selected_changed.emit()

func has_defence_selected() -> bool:
	return defence_selected != null
