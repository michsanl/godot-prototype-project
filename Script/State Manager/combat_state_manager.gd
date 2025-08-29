class_name CombatStateManager
extends Node

enum ClashState {
	TWO_SIDED,
	ONE_SIDED_ATTACKER,
	ONE_SIDED_DEFENDER,
	NONE,
}

signal combat_ended

@export var is_auto_roll: bool = true
@export var auto_roll_timer: float = 1.0
@export var clash_result_helper: ClashResultHelper
@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []

var _combat_ready_dice_slot_pool: Array[CharacterDiceSlot] = []


func handle_combat_state_enter() -> void:
	_start_combat_phase()


func handle_combat_state_exit() -> void:
	pass


#region Combat Phase Methods
func _start_combat_phase():
	# Initialize: only execute once on start
	await _initialize_combat_phase()
	
	# Core loop: execute each loop
	var combat_data: CombatData
	while _has_combat_ready_dice_slot(_combat_ready_dice_slot_pool):
		combat_data = _matchmake_single_combat() as CombatData
		await _start_combat(combat_data)
	
	# Finalize: only execute once on end
	await _finalize_combat_phase()


func _initialize_combat_phase():
	_collect_combat_ready_dice_slots()
	_sort_dice_slots_by_higher_speed()


func _finalize_combat_phase():
	for player in player_characters:
		player.reset_position()
		player.reset_visual()
	
	for enemy in enemy_characters:
		enemy.reset_position()
		enemy.reset_visual()
	
	combat_ended.emit()


func _matchmake_single_combat() -> CombatData:
	# Get combat pair
	var attacker_dice_slot = _combat_ready_dice_slot_pool[0]
	var defender_dice_slot = attacker_dice_slot.target_dice_slot
	
	# Commit combat pair
	if defender_dice_slot.target_dice_slot == attacker_dice_slot:
		_combat_ready_dice_slot_pool.erase(attacker_dice_slot)
		_combat_ready_dice_slot_pool.erase(defender_dice_slot)
	else:
		_combat_ready_dice_slot_pool.erase(attacker_dice_slot)
	
	# Create combat data
	var combat_data = CombatData.new(attacker_dice_slot, defender_dice_slot)
	
	return combat_data


func _has_combat_ready_dice_slot(dice_slot_pool: Array[CharacterDiceSlot]) -> bool:
	return not dice_slot_pool.is_empty()
#endregion


#region Single Combat Methods
func _start_combat(combat_data :CombatData):
	# Initialize: focus camera, show dice UI
	await _initialize_combat(combat_data)
	
	# Core: resolve clash until no dice left
	while combat_data.attacker_has_dice() or combat_data.defender_has_dice():
		var clash_state = _get_clash_state(combat_data)
		match clash_state:
			ClashState.TWO_SIDED:
				print("Both has dice. Perform two sided attack. ")
				await _start_two_sided_clash(combat_data)
			ClashState.ONE_SIDED_ATTACKER:
				print("Attacker has dice. Perform one sided attack. ")
			ClashState.ONE_SIDED_DEFENDER:
				print("Defender has dice. Perform one sided attack. ")
			ClashState.NONE:
				push_warning("Neither have dice, but clash is initiated. ")
				return
	
	# Finalize: unfocus camera, hide dice UI
	await _finalize_combat(combat_data)


func _initialize_combat(combat_data :CombatData):
	# TODO: focus camera, show dice UI, setup active dice
	pass


func _finalize_combat(combat_data :CombatData):
	# TODO: unfocus camera, hide dice UI
	pass


func _get_clash_state(combat_data :CombatData) -> int:
	var attacker_has = combat_data.attacker_has_dice()
	var defender_has = combat_data.defender_has_dice()
	
	if attacker_has and defender_has:
		return ClashState.TWO_SIDED
	elif attacker_has:
		return ClashState.ONE_SIDED_ATTACKER
	elif defender_has:
		return ClashState.ONE_SIDED_DEFENDER
	else:
		return ClashState.NONE
#endregion


#region Two Sided Attack Methods
func _start_two_sided_clash(combat_data :CombatData):
	# Initialize: approach movement phase
	await _initialize_two_sided_attack(combat_data)
	
	# Core: roll dice phase
	if not is_auto_roll:
		await _wait_for_space()
	else:
		await get_tree().create_timer(auto_roll_timer).timeout
	combat_data.roll_attacker_dice()
	combat_data.roll_defender_dice()
	await _resolve_clash_result(combat_data)
	
	# Finalize: resolve dice usage
	await _finalize_two_sided_attack(combat_data)


func _initialize_two_sided_attack(combat_data: CombatData):
	await _execute_two_sided_approach_movement(
		combat_data.attacker, 
		combat_data.defender
	)


func _finalize_two_sided_attack(combat_data: CombatData):
	combat_data.attacker_dice_pool.pop_front()
	combat_data.defender_dice_pool.pop_front()


func _resolve_clash_result(combat_data: CombatData):
	var attacker_clash_data = ClashData.new(combat_data, ClashData.CombatRole.ATTACKER)
	var defender_clash_data = ClashData.new(combat_data, ClashData.CombatRole.DEFENDER)
	
	if combat_data.attacker_roll_value > combat_data.defender_roll_value:
		# Attacker win
		await combat_data.attacker.apply_clash_win(attacker_clash_data)
	elif combat_data.attacker_roll_value < combat_data.defender_roll_value:
		# Defender 
		await combat_data.defender.apply_clash_win(defender_clash_data)
	else:
		# Draw
		combat_data.attacker.apply_clash_draw(attacker_clash_data)
		await combat_data.defender.apply_clash_draw(defender_clash_data)


func _wait_for_space():
	while true:
		await get_tree().process_frame
		if Input.is_key_pressed(KEY_SPACE):
			break
#endregion


#region One Sided Attack Methods

func _start_one_sided_attack(combat_data :CombatData):
	pass
#endregion


func _execute_two_sided_approach_movement(attacker: CharacterBase, defender: CharacterBase):
	attacker.approach_target_two_sided(defender)
	await defender.approach_target_two_sided(attacker)


func _execute_one_sided_approach_movement(actor: CharacterBase, target:CharacterBase):
	await actor.approach_target_one_sided(target)


func _collect_combat_ready_dice_slots():
	_collect_player_combat_ready_dice_slot()
	_collect_enemy_combat_ready_dice_slot()


func _collect_player_combat_ready_dice_slot():
	for player in player_characters:
		var dice_slot_pool = player.dice_slot_controller.get_dice_slot_pool()
		for dice_slot in dice_slot_pool:
			if dice_slot.target_dice_slot != null:
				_combat_ready_dice_slot_pool.append(dice_slot)


func _collect_enemy_combat_ready_dice_slot():
	for enemy in enemy_characters:
		var dice_slot_pool = enemy.dice_slot_controller.get_dice_slot_pool()
		for dice_slot in dice_slot_pool:
			if dice_slot.target_dice_slot != null:
				_combat_ready_dice_slot_pool.append(dice_slot)


func _sort_dice_slots_by_higher_speed():
	_combat_ready_dice_slot_pool.sort_custom(sort_ascending_dice_slot_speed)


func _set_attacker_dice_pool(combat_data: CombatData):
	var selected_ability = combat_data.attacker.get_random_ability() as AbilityData
	combat_data.attacker_dice_pool = selected_ability.dice_list.duplicate()


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
 

func sort_ascending_dice_slot_speed(a: CharacterDiceSlot, b: CharacterDiceSlot) -> bool:
	return a.speed_value > b.speed_value


func sort_ascending_character_dice(a: CharacterBase, b: CharacterBase) -> bool:
	return a.character_stat.dice_point > b.character_stat.dice_point
#endregion
