class_name ResolveStateManager
extends Node

signal resolve_ended

@export var characters: Array[CharacterController]


func handle_initialize_battle_enter() -> void:
	for character in characters:
		var dice_slots = character.dice_slot_controller.clear_all_dice_slot_data()
		
	resolve_ended.emit()


func handle_initialize_battle_exit() -> void:
	pass
