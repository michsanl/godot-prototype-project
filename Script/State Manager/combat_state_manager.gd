class_name CombatStateManager
extends Node

enum DiceBattleState {
	BOTH,
	ATTACKER_ONLY,
	DEFENDER_ONLY,
	NONE,
}

signal combat_ended

@export var is_manual_dice_roll: bool = true
@export var auto_roll_timer: float = 1.0
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
	_start_combat_phase()


func handle_combat_state_exit() -> void:
	pass


#region Combat Phase Methods
func _start_combat_phase():
	# Initialize: only execute once on start
	await _initialize_combat_phase()
	
	# Core: loop combat matchmaking
	var combat_data
	while has_combat_participant(_combat_participant_pool):
		combat_data = _matchmake_single_combat() as CombatData
		await _start_combat(combat_data)
	
	# Finalize: only execute once on end
	await _finalize_combat_phase()


func _initialize_combat_phase():
	_setup_combat_participant()
	_sort_combat_participant_by_highest_speed()


func _finalize_combat_phase():
	_attacker.reset_position()
	_attacker.reset_visual()
	_defender.reset_position()
	_defender.reset_visual()
	combat_ended.emit()


func _matchmake_single_combat() -> CombatData:
	var attacker = get_highest_speed_dice(_combat_participant_pool)
	var defender = get_target_dice(attacker)
	
	_commit_combat_pair(attacker, defender)
	
	var combat_data = CombatData.new()
	combat_data.attacker = attacker
	combat_data.defender = defender
	
	return combat_data


func _commit_combat_pair(attacker, defender):
	if (is_targeting_each_other(attacker, defender)):
		_erase_combat_participant(attacker)
		_erase_combat_participant(defender)
	else:
		_erase_combat_participant(attacker)
#endregion


#region Single Combat Methods
func _start_combat(combat_data :CombatData):
	# Initialize: focus camera, show dice UI, setup active dice
	await _initialize_combat(combat_data)
	
	# Core: loop dice attack
	while has_dice(_attacker_dice_pool) or has_dice(_defender_dice_pool):
			await _resolve_dice_attack(combat_data)
	
	# Finalize: unfocus camera
	await _finalize_combat(combat_data)


func _initialize_combat(combat_data :CombatData):
	# TODO: focus camera, show dice UI
	_set_attacker_dice_pool(combat_data)
	_set_defender_dice_pool(combat_data)



func _finalize_combat(combat_data :CombatData):
	# TODO: unfocus camera, despawn clash dice UI on character
	pass


func _resolve_dice_attack(combat_data :CombatData):
	var state = _get_clash_state(_attacker, _defender)
	
	match state:
		DiceBattleState.BOTH:
			print("Two sided attack performed. ")
			await _start_two_sided_attack(combat_data)
		DiceBattleState.ATTACKER_ONLY:
			print("One sided attack performed by first actor. ")
			await _execute_one_sided_approach_movement(_attacker, _defender)
			await _process_attacker_one_sided_token_attack()
		DiceBattleState.DEFENDER_ONLY:
			print("One sided attack performed by Second actor. ")
			await _execute_one_sided_approach_movement(_defender, _attacker)
			await _process_defender_one_sided_token_attack()
		DiceBattleState.NONE:
			# TODO: set warning, this state should never be called
			push_warning("DiceBattleState is NONE. This state should never be called.")
			return
#endregion


#region Two Sided Attack Methods
func _start_two_sided_attack(combat_data :CombatData):
	# Initialize: approach movement phase
	await _initialize_two_sided_attack(combat_data)
	
	# Core: roll dice phase
	if is_manual_dice_roll:
		await _wait_for_space()
	await _execute_dice_roll(combat_data.attacker)
	await _execute_dice_roll(combat_data.defender)
	await _resolve_character_action()
	
	# Finalize: commit used dice
	_finalize_two_sided_attack(combat_data)


func _initialize_two_sided_attack(combat_data: CombatData):
	await _execute_two_sided_approach_movement(
		combat_data.attacker, 
		combat_data.defender
	)


func _finalize_two_sided_attack(combat_data: CombatData):
	_attacker_dice_pool.pop_front()
	_defender_dice_pool.pop_front()


func _execute_dice_roll(actor: CharacterBase):
	_attacker_dice = _attacker_dice_pool[0]
	_defender_dice = _defender_dice_pool[0]
	_attacker_dice_value = _attacker_dice.roll_dice()
	_defender_dice_value = _defender_dice.roll_dice()
	_attacker_clash_result = calculate_clash_result(_attacker_dice_value, _defender_dice_value)
	_defender_clash_result = calculate_clash_result(_defender_dice_value, _attacker_dice_value)
	print("Attacker token value: ", _attacker_dice_value)
	print("Defender token value: ", _defender_dice_value)
	setup_attacker_clash_data()
	setup_defender_clash_data()


func _resolve_character_action():
	clash_result_helper.process_clash_response(_attacker_clash_data)
	await clash_result_helper.process_clash_response(_defender_clash_data)


func _wait_for_space():
	while true:
		await get_tree().process_frame
		if Input.is_key_pressed(KEY_SPACE):
			break

#endregion


#region One Sided Attack Methods

func _start_one_sided_attack(combat_data :CombatData):
	pass


func _process_one_sided_attack(attacker: CharacterBase, defender: CharacterBase):
	_set_attacker_dice_pool()
	
	while has_dice(_attacker_dice_pool):
		await _execute_one_sided_approach_movement(attacker, defender)
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


func _execute_two_sided_approach_movement(attacker: CharacterBase, defender: CharacterBase):
	attacker.approach_target_two_sided(defender)
	await defender.approach_target_two_sided(attacker)


func _execute_one_sided_approach_movement(actor: CharacterBase, target:CharacterBase):
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


func _set_attacker_dice_pool(combat_data: CombatData):
	var selected_ability = combat_data.attacker.get_random_ability() as AbilityData
	combat_data.attacker_dice_pool = selected_ability.dice_list.duplicate()


func _set_defender_dice_pool():
	var selected_ability: AbilityData = _defender.ability_manager.ability_list.pick_random()
	_defender_dice_pool = selected_ability.dice_list.duplicate()


func _get_clash_state(attacker :CharacterBase, defender :CharacterBase) -> int:
	var attacker_has
	var defender_has

	if attacker_has and defender_has:
		return DiceBattleState.BOTH
	elif attacker_has:
		return DiceBattleState.ATTACKER_ONLY
	elif defender_has:
		return DiceBattleState.DEFENDER_ONLY
	else:
		return DiceBattleState.NONE


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


func is_targeting_each_other(attacker: CharacterBase, defender: CharacterBase) -> bool:
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
