class_name CombatStateManager
extends Node

signal combat_ended

@export var player_characters: Array[CharacterController]
@export var enemy_characters: Array[CharacterController]
@export var clash_handler: ClashHandler

var _combat_ready_dice_slot_pool: Array[DiceSlotData] = []
var _matchmaker: ICombatMatchmaker
var _combat_data: CombatData


func _init() -> void:
	_matchmaker = DebugMatchmaker.new()


func handle_combat_state_enter() -> void:
	_start_combat_phase()


func handle_combat_state_exit() -> void:
	pass


#region Combat Phase Methods
func _start_combat_phase():
	# Initialize: only execute once on start
	await _initialize_combat_phase()
	
	# Core loop: execute each loop
	await _execute_combat_phase_loop()
	
	# Finalize: only execute once on end
	await _finalize_combat_phase()


func _initialize_combat_phase():
	_collect_combat_ready_dice_slots(player_characters)
	_collect_combat_ready_dice_slots(enemy_characters)
	_matchmaker.initialize(_combat_ready_dice_slot_pool)


func _execute_combat_phase_loop():	
	while _has_combat_ready_dice_slot(_combat_ready_dice_slot_pool):
		print("Has combat ready slot, starting combat!")
		_combat_data = _matchmaker.resolve(_combat_ready_dice_slot_pool)
		await clash_handler.start_combat(_combat_data)


func _finalize_combat_phase():
	for player in player_characters:
		player.reset_position()
		player.reset_visual()
	
	for enemy in enemy_characters:
		enemy.reset_position()
		enemy.reset_visual()
	
	combat_ended.emit()


func _has_combat_ready_dice_slot(dice_slot_pool: Array[DiceSlotData]) -> bool:
	return not dice_slot_pool.is_empty()


func _collect_combat_ready_dice_slots(character_pool: Array[CharacterController]):
	for character in character_pool:
		var dice_slot_pool = character.get_dice_slots()
		for dice_slot in dice_slot_pool:
			if dice_slot.target_dice_slot != null:
				_combat_ready_dice_slot_pool.append(dice_slot)
