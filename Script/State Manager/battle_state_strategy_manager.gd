extends Node

@export var player_characters: Array[Character_Base] = []
@export var enemy_characters: Array[Character_Base] = []


func set_player_and_enemy_target() -> void:
	_set_player_character_target()
	_set_enemy_character_target()


func clear_player_and_enemy_target() -> void:
	_clear_player_character_target()
	_clear_enemy_character_target()


func _set_player_character_target() -> void:
	for player in player_characters:
		player.character_targeting.set_target(enemy_characters.pick_random())


func _set_enemy_character_target() -> void:
	for enemy in enemy_characters:
		enemy.character_targeting.set_target(player_characters.pick_random())


func _clear_player_character_target() -> void:
	for player in player_characters:
		player.character_targeting.remove_target()


func _clear_enemy_character_target() -> void:
	for enemy in enemy_characters:
		enemy.character_targeting.remove_target()
