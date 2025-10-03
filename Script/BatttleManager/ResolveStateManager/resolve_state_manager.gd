class_name ResolveStateManager
extends Node

signal resolve_ended

@export var characters: Array[CharacterController]


func handle_initialize_battle_enter() -> void:
	for character in characters:
		character.clear_active_slots_data()
		character.get_facing().reset_facing()
		
		
	resolve_ended.emit()


func handle_initialize_battle_exit() -> void:
	pass
