extends Node2D
class_name Character_Targeting

@export var trajectory_ui: Trajectory_UI

signal on_target_changed(new_target: Vector2)
signal on_target_clear

var current_target: Character_Base


func _on_character_base_strategy_enter(target: Character_Base) -> void:
	set_target(target)

func _on_character_base_strategy_exit() -> void:
	remove_target()

func set_target(new_target: Character_Base) -> void:
	current_target = new_target
	trajectory_ui.handle_target_set(current_target)

func remove_target():
	current_target = null
	trajectory_ui.handle_target_clear()
