extends Node

@export var player_characters: Array[Character_Base] = []
@export var enemy_characters: Array[Character_Base] = []

#region set_target_automatically
func set_player_and_enemy_target() -> void:
	set_player_character_target()
	set_enemy_character_target()

func set_player_character_target() -> void:
	for player in player_characters:
		player.handle_strategy_enter(enemy_characters.pick_random())
		
func set_enemy_character_target() -> void:
	for enemy in enemy_characters:
		enemy.handle_strategy_enter(player_characters.pick_random())
#endregion

func remove_player_and_enemy_target() -> void:
	remove_player_character_target()
	remove_enemy_character_target()

func remove_player_character_target() -> void:
	for player in player_characters:
		player.handle_strategy_exit()
		
func remove_enemy_character_target() -> void:
	for enemy in enemy_characters:
		enemy.handle_strategy_exit()
