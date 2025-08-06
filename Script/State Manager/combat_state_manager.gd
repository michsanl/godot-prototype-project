class_name CombatStateManager
extends Node

signal combat_ended

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []

var combat_participants: Array[CharacterBase] = []


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
	var a_ability: Ability = a.character_ability_manager.get_random_ability()
	var b_ability: Ability = b.character_ability_manager.get_random_ability()
	var a_tokens: Array[AbilityToken] = a_ability.ability_stats.token.duplicate()
	var b_tokens: Array[AbilityToken] = b_ability.ability_stats.token.duplicate()
	
	while has_token(a_tokens) or has_token(b_tokens):
		if has_token(a_tokens) and has_token(b_tokens):
			print("A and B clash")
			await _move_character_to_each_other(a, b)
			await _process_two_sided_token_attack(a_tokens[0], b_tokens[0])
			a.reset_position()
			b.reset_position()
			a_tokens.pop_front()
			b_tokens.pop_front()
			await get_tree().create_timer(1.0).timeout
		elif has_token(a_tokens):
			print("A hitting B")
			await _move_character_to_target(a, b)
			await _process_one_sided_token_attack(a_tokens[0])
			a.reset_position()
			a_tokens.pop_front()
			await get_tree().create_timer(1.0).timeout
		elif has_token(b_tokens):
			print("B hitting A")
			await _move_character_to_target(b, a)
			await _process_one_sided_token_attack(b_tokens[0])
			b.reset_position()
			b_tokens.pop_front()
			await get_tree().create_timer(1.0).timeout

func _process_one_sided_attack(attacker: CharacterBase, target: CharacterBase):
	var selected_ability:= attacker.character_ability_manager.get_random_ability()
	var attacker_tokens:= selected_ability.ability_stats.token.duplicate()
	
	while has_token(attacker_tokens):
		await _process_one_sided_token_attack(attacker_tokens[0])
		await _move_character_to_target(attacker, target)
		attacker.reset_position()
		attacker_tokens.pop_front()

func _process_two_sided_token_attack(attacker: AbilityToken, target: AbilityToken):
	await get_tree().create_timer(0.25).timeout
	var attacker_value: int = attacker.get_token_value()
	var target_value: int = target.get_token_value()
	print("Attacker token value: ", attacker_value)
	print("Target token value: ", target_value)
	await get_tree().create_timer(0.25).timeout

func _process_one_sided_token_attack(attacker_token: AbilityToken):
	await get_tree().create_timer(0.25).timeout
	var token_value: int = _get_token_value(attacker_token)
	print("Attacker token value: ", token_value)
	await get_tree().create_timer(0.25).timeout
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
