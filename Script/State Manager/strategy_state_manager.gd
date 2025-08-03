class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []


func handle_strategy_state_enter() -> void:
	_set_player_character_target()
	_set_enemy_character_target()


func handle_strategy_state_exit() -> void:
	_clear_player_character_target()
	_clear_enemy_character_target()


func _set_player_character_target() -> void:
	for player in player_characters:
		player.character_targeting.set_target(enemy_characters.pick_random())
		player.character_stat.randomize_dice_point()


func _set_enemy_character_target() -> void:
	for enemy in enemy_characters:
		enemy.character_targeting.set_target(player_characters.pick_random())
		enemy.character_stat.randomize_dice_point()


func _clear_player_character_target() -> void:
	for player in player_characters:
		player.character_targeting.remove_target()


func _clear_enemy_character_target() -> void:
	for enemy in enemy_characters:
		enemy.character_targeting.remove_target()
