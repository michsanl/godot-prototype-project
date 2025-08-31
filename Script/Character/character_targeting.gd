class_name CharacterTargeting
extends Node2D

signal aim_target_added
signal aim_target_removed

var current_aim_target: CharacterController
var current_target: CharacterController



func set_target(new_target: CharacterController) -> void:
	current_target = new_target


func set_aim_target(new_target: CharacterController) -> void:
	current_aim_target = new_target
	aim_target_added.emit()


func remove_target() -> void:
	current_target = null


func remove_aim_target() -> void:
	current_aim_target = null
	aim_target_removed.emit()
