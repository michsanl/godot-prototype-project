class_name DebugButton
extends Node2D

@export var state_manager: StateManager
@export var strategy_button: Button
@export var combat_button: Button
@export var resolve_button: Button

@export var player_character: CharacterController
@export var enemy_character: CharacterController


func _on_strategy_button_pressed() -> void:
	state_manager.change_state_to_strategy()


func _on_combat_button_pressed() -> void:
	state_manager.change_state_to_combat()


func _on_resolve_button_pressed() -> void:
	state_manager.change_state_to_resolve()


func _on_move_button_pressed() -> void:
	player_character.approach_target_two_sided(enemy_character)
