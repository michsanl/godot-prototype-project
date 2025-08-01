class_name CharacterTargeting
extends Node2D

signal target_changed
signal target_removed

var current_target: Character_Base

func set_target(new_target: Character_Base) -> void:
	current_target = new_target
	target_changed.emit()

func remove_target() -> void:
	current_target = null
	target_removed.emit()
