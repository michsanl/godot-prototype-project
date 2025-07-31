extends Node2D
class_name Character_Targeting

signal on_target_changed(new_target)

var current_target: Character_Base

func set_target(new_target: Character_Base) -> void:
	current_target = new_target
	on_target_changed.emit(current_target)

func remove_target():
	current_target = null
	on_target_changed.emit(current_target)
