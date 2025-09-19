class_name InitializeBattleManager
extends Node

signal initialize_ended

func handle_initialize_battle_enter() -> void:
	await get_tree().create_timer(1.0).timeout
	initialize_ended.emit()


func handle_initialize_battle_exit() -> void:
	pass
	
