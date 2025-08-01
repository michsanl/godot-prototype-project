extends Node

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []

var combat_participant: Array[CharacterBase] = []


func _on_battle_state_manager_combat_phase_started() -> void:
	setup_combat_participant()
	evaluate_combat()


func _on_battle_state_manager_combat_phase_ended() -> void:
	combat_participant.clear()


func setup_combat_participant():
	gather_attacking_character(player_characters)
	gather_attacking_character(enemy_characters)
	combat_participant.sort_custom(sort_ascending_character_dice)
	
	print("combat participant: ", combat_participant)


func gather_attacking_character(character_pool: Array[CharacterBase]):
	for character in character_pool:
		if character.character_targeting.current_target != null:
			combat_participant.append(character)


func sort_ascending_character_dice(a: CharacterBase, b: CharacterBase) -> bool:
	return a.character_stat.dice_point > b.character_stat.dice_point



func evaluate_combat():
	while combat_participant.is_empty() != true:
		var attacker = combat_participant[0]
		var target = attacker.character_targeting.current_target
		var target_target = target.character_targeting.current_target
		
		if (target_target == attacker):
			process_two_sided_combat(attacker, target)
			combat_participant.erase(attacker)
			combat_participant.erase(target)
			print("handle_clash")
		else:
			combat_participant.erase(attacker)
			print("handle_one_sided_attack")


func process_two_sided_combat(a: CharacterBase, b:CharacterBase):
	var a_ability: Ability = a.character_ability_manager.get_random_ability()
	var b_ability: Ability = b.character_ability_manager.get_random_ability()
	
	var a_tokens: Array[AbilityToken] = a_ability.ability_stats.token.duplicate()
	var b_tokens: Array[AbilityToken] = b_ability.ability_stats.token.duplicate()
	
	while not a_tokens.is_empty() or not b_tokens.is_empty():
		if not a_tokens.is_empty() and not b_tokens.is_empty():
			print("A and B clash")
			a_tokens.pop_front()
			b_tokens.pop_front()
		elif not a_tokens.is_empty():
			print("A hitting B")
			a_tokens.pop_front()
		elif not b_tokens.is_empty():
			print("B hitting A")
			b_tokens.pop_front()
	
