class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []


func handle_strategy_state_enter() -> void:
	_randomize_player_target()
	_randomize_enemy_target()


func handle_strategy_state_exit() -> void:
	_clear_player_aim_target()
	_clear_enemy_aim_target()


func _randomize_player_dice_point() -> void:
	for player in player_characters:
		player.randomize_dice_point()


func _randomize_enemy_dice_point() -> void:
	for enemy in enemy_characters:
		enemy.randomize_dice_point()


func _randomize_player_target() -> void:
	for player in player_characters:
		var target: CharacterBase = enemy_characters.pick_random()
		player.set_target(target)
		player.set_aim_target(target)


func _randomize_enemy_target() -> void:
	for enemy in enemy_characters:
		var target: CharacterBase = player_characters.pick_random()
		enemy.set_target(target)
		enemy.set_aim_target(target)
		enemy.randomize_dice_point()


func _clear_player_aim_target() -> void:
	for player in player_characters:
		player.remove_aim_target()


func _clear_enemy_aim_target() -> void:
	for enemy in enemy_characters:
		enemy.remove_aim_target()
