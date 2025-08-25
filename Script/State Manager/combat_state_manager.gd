class_name CombatStateManager
extends Node

enum ClashState {
	BOTH,
	ATTACKER_ONLY,
	DEFENDER_ONLY,
	NONE
}

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
	_start_combat_state_loop()


func handle_combat_state_exit() -> void:
	pass


#region Primary Methods
func _start_combat_state_loop():
	# TODO: On Started
	
	# TODO: Combat Loop
	while has_combat_participant(_combat_participant_pool):
		_attacker = get_highest_speed_dice(_combat_participant_pool)
		_defender = get_target_dice(_attacker)
		
		if (is_defender_targeting_attacker(_attacker, _defender)):
			await _resolve_single_combat(_attacker)
			_erase_combat_participant(_attacker)
			_erase_combat_participant(_defender)
		else:
			await _process_one_sided_attack(_attacker, _defender)
			_erase_combat_participant(_attacker)
	
	# TODO: On Ended
	_attacker.reset_position()
	_attacker.reset_visual()
	_defender.reset_position()
	_defender.reset_visual()
	combat_ended.emit()


func both_have_dices(chara1 :CharacterBase, chara2: CharacterBase):
	pass
func either_has_dice(chara1 :CharacterBase, chara2: CharacterBase):
	pass


func _start_single_combat():
	# TODO: setup both combat participants' active dice
	
	# Clash loop. Ends after both have no dice
	while either_has_dice(_attacker, _defender):
		await _resolve_clash()
	
	# TODO: finalize combat (rewards, cleanup, etc.)


func _resolve_clash():
	var state = _get_clash_state(_attacker, _defender)
	
	match state:
		ClashState.BOTH:
			# TODO: start two sided clash
			pass
		ClashState.ATTACKER_ONLY:
			# TODO: start one sided clash attacker
			pass
		ClashState.DEFENDER_ONLY:
			# TODO: start one sided clash defender
			pass
		ClashState.NONE:
			# TODO: set warning
			return


func _get_clash_state(attacker :CharacterBase, defender :CharacterBase) -> int:
	var attacker_has
	var defender_has

	if attacker_has and defender_has:
		return ClashState.BOTH
	elif attacker_has:
		return ClashState.ATTACKER_ONLY
	elif defender_has:
		return ClashState.DEFENDER_ONLY
	else:
		return ClashState.NONE

func _start_clash():
	# Step 1, Focus camera & background + Spawn clash dice UI
	# TODO:
	# Loop step 2 - 4 until no dice left
	# Step 2: Character show intent + Character approach target
	# TODO: command character setup active dice pool
	_attacker.setup_active_dice_pool()
	_defender.setup_active_dice_pool()
	# TODO: command character approach target if has dice
	while either_has_dice(_attacker, _defender):
		await _resolve_clash()
		
	# Step 3: Enable roll dice player input + Character slowly approach target
	# TODO: 
	# Step 4: Character perform dice action
	# TODO: 
	# TODO: Step 5: de-Focus camera & background + de-Spawn clash dice UI 
	pass


func _resolve_single_combat(attacker :CharacterBase):
	_set_attacker_dice_pool()
	_set_defender_dice_pool()
	
	while has_dice(_attacker_dice_pool) or has_dice(_defender_dice_pool):
		if has_dice(_attacker_dice_pool) and has_dice(_defender_dice_pool):
			print("A and B clash")
			await _move_character_to_each_other()
			await _process_two_sided_token_attack()
		elif has_dice(_attacker_dice_pool):
			print("A hitting B")
			await _move_character_to_target(_attacker, _defender)
			await _process_attacker_one_sided_token_attack()
		elif has_dice(_defender_dice_pool):
			print("B hitting A")
			await _move_character_to_target(_defender, _attacker)
			await _process_defender_one_sided_token_attack()
		
		_attacker.reset_visual()
		_defender.reset_visual()


func _process_one_sided_attack(attacker: CharacterBase, defender: CharacterBase):
	_set_attacker_dice_pool()
	
	while has_dice(_attacker_dice_pool):
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
	print("Defender token value: ", _defender_dice_value)
	
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
	print("Attacker token value: ", _attacker_dice_value)
	
	setup_attacker_clash_data()
	
	await clash_result_helper.process_clash_response(_attacker_clash_data)
	
	_attacker_dice_pool.pop_front()


func _process_defender_one_sided_token_attack():
	# Sequence : spawn dice UI -> roll dice -> apply token effect
	_defender_dice = _defender_dice_pool[0]
	
	await get_tree().create_timer(0.75).timeout 
	
	_defender_dice_value = _defender_dice.roll_dice()
	print("Defender token value: ", _defender_dice_value)
	
	setup_defender_clash_data()
	
	await clash_result_helper.process_clash_response(_defender_clash_data)
	
	_defender_dice_pool.pop_front()
#endregion


func _move_character_to_each_other():
	_attacker.approach_target_two_sided(_defender)
	await _defender.approach_target_two_sided(_attacker)


func _move_character_to_target(actor: CharacterBase, target:CharacterBase):
	await actor.approach_target_one_sided(target)


func _setup_combat_participant():
	_gather_combat_participant(player_characters)
	_gather_combat_participant(enemy_characters)


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
	var clash_data = ClashData.new()
	
	clash_data.clash_result = _attacker_clash_result
	
	clash_data.owner_name = "Attacker"
	clash_data.owner = _attacker
	clash_data.owner_token = _attacker_dice
	clash_data.owner_token_value = _attacker_dice_value
	
	clash_data.opponent = _defender
	clash_data.opponent_token = _defender_dice
	clash_data.opponent_token_value = _defender_dice_value
	
	_attacker_clash_data = clash_data


func setup_defender_clash_data():
	var clash_data = ClashData.new()
	
	clash_data.clash_result = _defender_clash_result
	
	clash_data.owner_name = "Defender"
	clash_data.owner = _defender
	clash_data.owner_token = _defender_dice
	clash_data.owner_token_value = _defender_dice_value
	
	clash_data.opponent = _attacker
	clash_data.opponent_token = _attacker_dice
	clash_data.opponent_token_value = _attacker_dice_value
	
	_defender_clash_data = clash_data


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


func has_dice(token_pool: Array[DiceData]) -> bool:
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




func start_clash():
	# 1. Clash Started
	# TODO: camera and background focus
	
	
	# 2. Approach Phase
	# TODO: character:  move to face to face position
	
	
	# 3. Dice Roll Phase
	# TODO: character: set up active dice pool
	#       character: move slowly towards target
	#       player input: enable dice roll input
	
	
	# 4. Action Phase
	# TODO: character: perform dice action
	
	
	pass


# Combat State Sequence:
# 1. on combat state start:
#    - command all character move towards their highest dice target
# 2. on character reach their target clash trigger zone: 
#    - signal clash manager to initiate clash
# 3. on clash manager receive signal from character:
#    - command clashing characters move to face eachother
#    - command clashing characters spawn clash dice UI
#    - command clashing characters setup active dice pool
# 4. on clashing characters face eachothey r:
#    - command clashing characters displaactive dice pool
#    - command clashing characters slowly move closer to target
#    - await player input to roll dice
# 5. on dice rolled:
#    - command clashing characters perform their active token
