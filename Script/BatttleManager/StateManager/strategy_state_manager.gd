class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterController]
@export var enemy_characters: Array[CharacterController]

var _player_dice_slots: Array[DiceSlotData]
var _enemy_dice_slots: Array[DiceSlotData]

func handle_strategy_state_enter() -> void:
	_set_character_dice_slot_visibility(true)
	
	_gather_character_active_dice_slots()
	_roll_character_dice_slot()
	
	_execute_state_enter_debug_methods()


func handle_strategy_state_exit() -> void:
	_set_character_dice_slot_visibility(false)


# Temporary method for testing
func _execute_state_enter_debug_methods():
	_randomize_character_dice_slot_ability()
	_randomize_character_dice_slot_target()


func _set_character_dice_slot_visibility(condition: bool):
	for player in player_characters:
		player.dice_slot_controller.set_visibility(condition)
	for enemy in enemy_characters:
		enemy.dice_slot_controller.set_visibility(condition)


func _gather_character_active_dice_slots():
	for player in player_characters:
		var dice_slots = player.dice_slot_controller.dice_slots
		for dice_slot in dice_slots:
			if dice_slot.state == DiceSlotData.DiceSlotState.ACTIVE:
				_player_dice_slots.append(dice_slot)
	
	for enemy in enemy_characters:
		var dice_slots = enemy.dice_slot_controller.dice_slots
		for dice_slot in dice_slots:
			if dice_slot.state == DiceSlotData.DiceSlotState.ACTIVE:
				_enemy_dice_slots.append(dice_slot)


func _roll_character_dice_slot():
	for slot in _player_dice_slots:
		slot.roll_speed_value()
	
	for slot in _enemy_dice_slots:
		slot.roll_speed_value()


func _randomize_character_dice_slot_ability():
	for slot in _player_dice_slots:
		var ability = slot.owner_character.ability_controller.ability_list.pick_random()
		slot.set_selected_ability(ability)
	
	for slot in _enemy_dice_slots:
		var ability = slot.owner_character.ability_controller.ability_list.pick_random()
		slot.set_selected_ability(ability)


func _randomize_character_dice_slot_target():
	for player_slot in _player_dice_slots:
		player_slot.set_target_slot(_enemy_dice_slots.pick_random())
	
	for enemy_slot in _enemy_dice_slots:
		enemy_slot.set_target_slot(_player_dice_slots.pick_random())
