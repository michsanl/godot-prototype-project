class_name CombatStateManager
extends Node

signal combat_ended

@export var clash_result_helper: ClashResultHelper
@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []

var _combat_participant_pool: Array[CharacterBase] = []
var _attacker_clash_data: ClashData = ClashData.new()
var _defender_clash_data: ClashData = ClashData.new()

var _attacker_dice_pool: Array[DiceData] = []
var _defender_dice_pool: Array[DiceData] = []
var _attacker: CharacterBase
var _defender: CharacterBase
var _attacker_dice: DiceData
var _defender_dice: DiceData
var _attacker_dice_value: int
var _defender_dice_value: int
var _attacker_clash_result: ClashData.ClashResult
var _defender_clash_result: ClashData.ClashResult


func handle_combat_state_enter() -> void:
	_setup_combat_participant()
	_sort_combat_participant_by_highest_speed()
	_process_combat_by_highest_speed()


func handle_combat_state_exit() -> void:
	pass


#region Primary Methods
func _setup_combat_participant():
	_gather_combat_participant(player_characters)
	_gather_combat_participant(enemy_characters)


func _process_combat_by_highest_speed():
	while has_combat_participant(_combat_participant_pool):
		_attacker = get_highest_speed_dice(_combat_participant_pool)
		_defender = get_target_dice(_attacker)
		
		if (is_defender_targeting_attacker(_attacker, _defender)):
			await _process_two_sided_attack()
			_erase_combat_participant(_attacker)
			_erase_combat_participant(_defender)
		else:
			await _process_one_sided_attack(_attacker, _defender)
			_erase_combat_participant(_attacker)
	
	_attacker.reset_character_condition()
	_defender.reset_character_condition()
	
	combat_ended.emit()


func _process_two_sided_attack():
	_set_attacker_dice_pool()
	_set_defender_dice_pool()
	
	while has_token(_attacker_dice_pool) or has_token(_defender_dice_pool):
		if has_token(_attacker_dice_pool) and has_token(_defender_dice_pool):
			print("A and B clash")
			await _move_character_to_each_other()
			await _process_two_sided_token_attack()
		elif has_token(_attacker_dice_pool):
			print("A hitting B")
			await _move_character_to_target(_attacker, _defender)
			await _process_attacker_one_sided_token_attack()
		elif has_token(_defender_dice_pool):
			print("B hitting A")
			await _move_character_to_target(_defender, _attacker)
			await _process_defender_one_sided_token_attack()


func _process_one_sided_attack(attacker: CharacterBase, defender: CharacterBase):
	_set_attacker_dice_pool()
	
	while has_token(_attacker_dice_pool):
		await _move_character_to_target(attacker, defender)
		await _process_attacker_one_sided_token_attack()

func _process_two_sided_token_attack():
	# Sequence : spawn dice UI -> roll dice -> apply token effect
	_attacker_dice = _attacker_dice_pool[0]
	_defender_dice = _defender_dice_pool[0]
	
	await get_tree().create_timer(0.75).timeout
	
	_attacker_dice_value = _attacker_dice.roll_dice()
	_defender_dice_value = _defender_dice.roll_dice()
	_attacker_clash_result = calculate_clash_result(_attacker_dice_value, _defender_dice_value)
	_defender_clash_result = calculate_clash_result(_defender_dice_value, _attacker_dice_value)
	print("Attacker token value: ", _attacker_dice_value)
	print("Target token value: ", _defender_dice_value)
	
	setup_attacker_clash_data()
	setup_defender_clash_data()
	
	clash_result_helper.process_clash_response(_attacker_clash_data)
	await clash_result_helper.process_clash_response(_defender_clash_data)
	
	_attacker_dice_pool.pop_front()
	_defender_dice_pool.pop_front()


func _process_attacker_one_sided_token_attack():
	# Sequence : spawn dice UI -> roll dice -> apply token effect
	_attacker_dice = _attacker_dice_pool[0]
	
	await get_tree().create_timer(0.75).timeout
	
	_attacker_dice_value = _attacker_dice.roll_dice()
	print("Defender token value: ", _attacker_dice_value)
	
	_attacker.perform_slash_attack_win(_defender)
	await _defender.perform_damaged_action(_attacker)
	
	_attacker_dice_pool.pop_front()


func _process_defender_one_sided_token_attack():
	# Sequence : spawn dice UI -> roll dice -> apply token effect
	_defender_dice = _defender_dice_pool[0]
	
	await get_tree().create_timer(0.75).timeout 
	
	_defender_dice_value = _defender_dice.roll_dice()
	print("Defender token value: ", _defender_dice_value)
	
	_defender.perform_slash_attack_win(_attacker)
	await _attacker.perform_damaged_action(_defender)
	
	_defender_dice_pool.pop_front()
#endregion


func _move_character_to_each_other():
	_attacker.approach_target_two_sided(_defender)
	await _defender.approach_target_two_sided(_attacker)


func _move_character_to_target(a: CharacterBase, target:CharacterBase):
	await a.approach_target_one_sided(target)


func _gather_combat_participant(character_pool: Array[CharacterBase]):
	for character in character_pool:
		if character.character_targeting.current_target != null:
			_combat_participant_pool.append(character)


func _erase_combat_participant(character: CharacterBase):
	_combat_participant_pool.erase(character)


func _clear_combat_participant():
	_combat_participant_pool.clear()


func _sort_combat_participant_by_highest_speed():
	_combat_participant_pool.sort_custom(sort_ascending_character_dice)


func _set_attacker_dice_pool():
	var selected_ability: AbilityData = _attacker.ability_manager.ability_list.pick_random()
	_attacker_dice_pool = selected_ability.dice_list.duplicate()


func _set_defender_dice_pool():
	var selected_ability: AbilityData = _defender.ability_manager.ability_list.pick_random()
	_defender_dice_pool = selected_ability.dice_list.duplicate()


func setup_attacker_clash_data():
	_attacker_clash_data = ClashData.new()
	
	_attacker_clash_data.clash_result = _attacker_clash_result
	
	_attacker_clash_data.owner_name = "Attacker"
	_attacker_clash_data.owner = _attacker
	_attacker_clash_data.owner_token = _attacker_dice
	_attacker_clash_data.owner_token_value = _attacker_dice_value
	
	_attacker_clash_data.opponent = _defender
	_attacker_clash_data.opponent_token = _defender_dice
	_attacker_clash_data.opponent_token_value = _defender_dice_value


func setup_defender_clash_data():
	_defender_clash_data = ClashData.new()
	
	_defender_clash_data.clash_result = _defender_clash_result
	
	_defender_clash_data.owner_name = "Defender"
	_defender_clash_data.owner = _defender
	_defender_clash_data.owner_token = _defender_dice
	_defender_clash_data.owner_token_value = _defender_dice_value
	
	_defender_clash_data.opponent = _attacker
	_defender_clash_data.opponent_token = _attacker_dice
	_defender_clash_data.opponent_token_value = _attacker_dice_value


func calculate_clash_result(owner_token_val: int, opponent_token_val: int) -> ClashData.ClashResult:
	if owner_token_val > opponent_token_val:
		return ClashData.ClashResult.WIN
	elif owner_token_val < opponent_token_val:
		return ClashData.ClashResult.LOSE
	else:
		return ClashData.ClashResult.DRAW


#region Helper Methods
func has_combat_participant(characer_pool: Array[CharacterBase]) -> bool:
	return not characer_pool.is_empty()


func has_token(token_pool: Array[DiceData]) -> bool:
	return not token_pool.is_empty()


func get_target_dice(character: CharacterBase) -> CharacterBase:
	return character.character_targeting.current_target


func get_highest_speed_dice(character_pool: Array[CharacterBase]) -> CharacterBase:
	return character_pool[0] #  Use this after sorting the pool


func is_defender_targeting_attacker(attacker: CharacterBase, defender: CharacterBase) -> bool:
	var current_target: CharacterBase = defender.character_targeting.current_target
	if current_target == null:
		return false
	
	return current_target == attacker
 

func sort_ascending_character_dice(a: CharacterBase, b: CharacterBase) -> bool:
	return a.character_stat.dice_point > b.character_stat.dice_point
#endregion
