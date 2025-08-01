class_name CharacterTargeting
extends Node2D

signal target_changed
signal target_removed

var current_aim_target: CharacterBase
var current_target: CharacterBase

func set_target(new_target: CharacterBase) -> void:
	current_target = new_target
	current_aim_target = new_target
	target_changed.emit()


func remove_target() -> void:
	current_aim_target = null
	target_removed.emit()
