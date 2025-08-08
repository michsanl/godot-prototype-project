class_name CombatStateManager
extends Node

signal combat_ended

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []
@export var player_ability_stats: AbilityStats
@export var enemy_ability_stats: AbilityStats

var _combat_participant_pool: Array[CharacterBase] = []
var _attacker_token_pool: Array[AbilityToken] = []
var _defender_token_pool: Array[AbilityToken] = []
var _attacker: CharacterBase
var _defender: CharacterBase
var _attacker_token: AbilityToken
var _defender_token: AbilityToken
var _attacker_token_value: int
var _defender_token_value: int

func handle_combat_state_enter() -> void:
	_setup_combat_participant()
	_sort_combat_participant_by_highest_speed()
	_process_combat_by_highest_speed()


func handle_combat_state_exit() -> void:
	pass


#region Primary Methods
func _setup_combat_participant():
	_gather_combat_participant_from(player_characters)
	_gather_combat_participant_from(enemy_characters)


func _process_combat_by_highest_speed():
	while has_combat_participant(_combat_participant_pool):
		_attacker = get_highest_speed_character(_combat_participant_pool)
		_defender = get_target_character(_attacker)
		
		if (is_attacking_each_other(_attacker, _defender)):
			await _process_two_sided_attack()
			_erase_combat_participant(_attacker)
			_erase_combat_participant(_defender)
		else:
			await _process_one_sided_attack(_attacker, _defender)
			_erase_combat_participant(_attacker)
	
	combat_ended.emit()


func _process_two_sided_attack():
	_setup_attacker_token_pool()
	_setup_defender_token_pool()
	
	while has_token(_attacker_token_pool) or has_token(_defender_token_pool):
		if has_token(_attacker_token_pool) and has_token(_defender_token_pool):
			print("A and B clash")
			await _move_character_to_each_other()
			await _process_two_sided_token_attack()
		elif has_token(_attacker_token_pool):
			print("A hitting B")
			await _move_character_to_target(_attacker, _defender)
			await _process_attacker_one_sided_token_attack()
		elif has_token(_defender_token_pool):
			print("B hitting A")
			await _move_character_to_target(_defender, _attacker)
			await _process_defender_one_sided_token_attack()


func _process_one_sided_attack(attacker: CharacterBase, target: CharacterBase):
	_setup_attacker_token_pool()
	
	while has_token(_attacker_token_pool):
		await _move_character_to_target(attacker, target)
		await _process_attacker_one_sided_token_attack()

func _process_two_sided_token_attack():
	await get_tree().create_timer(0.75).timeout
	
	var attacker_token: AbilityToken = _attacker_token_pool[0]
	var target_token: AbilityToken = _defender_token_pool[0]
	var attacker_token_value: int = attacker_token.get_token_value()
	var target_token_value: int = target_token.get_token_value()
	print("Attacker token value: ", attacker_token_value)
	print("Target token value: ", target_token_value)
	
	await get_tree().create_timer(1.0).timeout
	
	_attacker.reset_position()
	_defender.reset_position()
	_attacker_token_pool.pop_front()
	_defender_token_pool.pop_front()


func _process_attacker_one_sided_token_attack():
	await get_tree().create_timer(0.75).timeout
	
	_attacker_token = _attacker_token_pool[0]
	_attacker_token_value = _attacker_token.get_token_value()
	print("Defender token value: ", _attacker_token_value)
	
	await get_tree().create_timer(1.0).timeout
	
	_attacker.reset_position()
	_attacker_token_pool.pop_front()


func _process_defender_one_sided_token_attack():
	await get_tree().create_timer(0.75).timeout
	
	_defender_token = _defender_token_pool[0]
	_defender_token_value = _defender_token.get_token_value()
	print("Defender token value: ", _defender_token_value)
	
	await get_tree().create_timer(1.0).timeout
	
	_defender.reset_position()
	_defender_token_pool.pop_front()
#endregion


func _move_character_to_each_other():
	_attacker.approach_target_two_sided(_defender)
	await _defender.approach_target_two_sided(_attacker)


func _move_character_to_target(a: CharacterBase, target:CharacterBase):
	await a.approach_target_one_sided(target)


func _gather_combat_participant_from(character_pool: Array[CharacterBase]):
	for character in character_pool:
		if character.character_targeting.current_target != null:
			_combat_participant_pool.append(character)


func _erase_combat_participant(character: CharacterBase):
	_combat_participant_pool.erase(character)


func _clear_combat_participant():
	_combat_participant_pool.clear()


func _sort_combat_participant_by_highest_speed():
	_combat_participant_pool.sort_custom(sort_ascending_character_dice)


func _setup_attacker_token_pool():
	var selected_ability: Ability = _attacker.character_ability_manager.abilities.pick_random()
	_attacker_token_pool = selected_ability.ability_stats.token.duplicate()


func _setup_defender_token_pool():
	var selected_ability: Ability = _defender.character_ability_manager.abilities.pick_random()
	_defender_token_pool = selected_ability.ability_stats.token.duplicate()


func _get_token_value(token: AbilityToken) -> int:
	return token.get_token_value()


func create_ability_class():
	return preload("res://Script/Character Component/Character Ability/ability.gd").new()


#region Helper Methods
func has_combat_participant(characer_pool: Array[CharacterBase]) -> bool:
	return not characer_pool.is_empty()


func has_token(token_pool: Array[AbilityToken]) -> bool:
	return not token_pool.is_empty()


func get_target_character(character: CharacterBase) -> CharacterBase:
	return character.character_targeting.current_target


func get_highest_speed_character(character_pool: Array[CharacterBase]) -> CharacterBase:
	return character_pool[0] #  Use this after sorting the pool


func is_attacking_each_other(a: CharacterBase, b: CharacterBase) -> bool:
	var a_targets_b : bool = a.character_targeting.current_target == b
	var b_targets_a : bool = b.character_targeting.current_target == a
	return a_targets_b and b_targets_a


func sort_ascending_character_dice(a: CharacterBase, b: CharacterBase) -> bool:
	return a.character_stat.dice_point > b.character_stat.dice_point
#endregion
