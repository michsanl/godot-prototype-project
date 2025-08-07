class_name CombatStateManager
extends Node

signal combat_ended

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []
@export var ability_stats: Array[AbilityStats] = []

var combat_participants: Array[CharacterBase] = []
var ability_pool: Array[Ability] = []
var a_token_pool: Array[AbilityToken] = []
var b_token_pool: Array[AbilityToken] = []

func _ready() -> void:
	setup_ability()


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
	while has_combat_participant(combat_participants):
		var attacker = get_highest_speed_character(combat_participants)
		var target = get_target_character(attacker)
		
		if (is_attacking_each_other(attacker, target)):
			await _process_two_sided_attack(attacker, target)
			_erase_combat_participant(attacker)
			_erase_combat_participant(target)
		else:
			await _process_one_sided_attack(attacker, target)
			_erase_combat_participant(attacker)
	
	combat_ended.emit()


func _process_two_sided_attack(a: CharacterBase, b:CharacterBase):
	a_token_pool = ability_pool[0].ability_stats.token.duplicate()
	b_token_pool = ability_pool[1].ability_stats.token.duplicate()
	
	while has_token(a_token_pool) or has_token(b_token_pool):
		if has_token(a_token_pool) and has_token(b_token_pool):
			print("A and B clash")
			await _move_character_to_each_other(a, b)
			await _process_two_sided_token_attack(a_token_pool[0], b_token_pool[0])
			a.reset_position()
			b.reset_position()
			a_token_pool.pop_front()
			b_token_pool.pop_front()
			await get_tree().create_timer(1.0).timeout
		elif has_token(a_token_pool):
			print("A hitting B")
			await _move_character_to_target(a, b)
			await _process_one_sided_token_attack(a_token_pool[0])
			a.reset_position()
			a_token_pool.pop_front()
			await get_tree().create_timer(1.0).timeout
		elif has_token(b_token_pool):
			print("B hitting A")
			await _move_character_to_target(b, a)
			await _process_one_sided_token_attack(b_token_pool[0])
			b.reset_position()
			b_token_pool.pop_front()
			await get_tree().create_timer(1.0).timeout

func _process_one_sided_attack(attacker: CharacterBase, target: CharacterBase):
	var selected_ability:= attacker.character_ability_manager.get_random_ability()
	var attacker_tokens:= selected_ability.ability_stats.token.duplicate()
	
	while has_token(attacker_tokens):
		await _move_character_to_target(attacker, target)
		await _process_one_sided_token_attack(attacker_tokens[0])
		attacker.reset_position()
		attacker_tokens.pop_front()

func _process_two_sided_token_attack(attacker: AbilityToken, target: AbilityToken):
	await get_tree().create_timer(0.25).timeout
	var attacker_value: int = attacker.get_token_value()
	var target_value: int = target.get_token_value()
	print("Attacker token value: ", attacker_value)
	print("Target token value: ", target_value)
	await get_tree().create_timer(0.5).timeout

func _process_one_sided_token_attack(attacker_token: AbilityToken):
	await get_tree().create_timer(0.25).timeout
	var token_value: int = _get_token_value(attacker_token)
	print("Attacker token value: ", token_value)
	await get_tree().create_timer(0.5).timeout
#endregion


func _get_token_value(token: AbilityToken) -> int:
	return token.get_token_value()


func _move_character_to_each_other(a: CharacterBase, b:CharacterBase):
	a.approach_target_two_sided(b)
	await b.approach_target_two_sided(a)


func _move_character_to_target(a: CharacterBase, target:CharacterBase):
	await a.approach_target_one_sided(target)


func _gather_combat_participant_from(character_pool: Array[CharacterBase]):
	for character in character_pool:
		if character.character_targeting.current_target != null:
			combat_participants.append(character)


func _erase_combat_participant(character: CharacterBase):
	combat_participants.erase(character)


func _clear_combat_participant():
	combat_participants.clear()


func _sort_combat_participant_by_highest_speed():
	combat_participants.sort_custom(sort_ascending_character_dice)


func setup_ability():
	for stats in ability_stats:
		var ability = create_ability_class()
		ability.ability_stats = stats
		ability_pool.append(ability)


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
