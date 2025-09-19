class_name CharacterManager
extends Node

@export var player_characters: Array[CharacterController] = []
@export var enemy_characters: Array[CharacterController] = []
var all_characters: Array[CharacterController] = []

func _init() -> void:
	all_characters.append_array(player_characters)
	all_characters.append_array(enemy_characters)

func get_player_characters() -> Array[CharacterController]:
	return player_characters

func get_enemy_characters() -> Array[CharacterController]:
	return enemy_characters

func get_all_characters() -> Array[CharacterController]:
	return all_characters
