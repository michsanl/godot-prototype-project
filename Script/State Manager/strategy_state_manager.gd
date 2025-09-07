class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterController]
@export var enemy_characters: Array[CharacterController]


func handle_strategy_state_enter() -> void:
	_randomize_character_dice_speed(player_characters)
	_randomize_character_dice_speed(enemy_characters)
	_randomize_character_ability(player_characters)
	_randomize_character_ability(enemy_characters)
	_randomize_player_target()
	_randomize_enemy_target()


func handle_strategy_state_exit() -> void:
	pass

# FIXME: remove old method
func _randomize_character_dice_speed(characer_pool: Array[CharacterController]):
	for character in characer_pool:
		character.dice_slot_controller.roll_all_dice_slots()
		character.dice_control.roll_active_dice_slot()


func _randomize_character_ability(characer_pool: Array[CharacterController]):
	for character in characer_pool:
		var dice_slot_pool = character.dice_slot_controller.get_dice_slot_pool()
		for dice_slot in dice_slot_pool:
			var ablity = character.ability_controller.get_random_ability()
			dice_slot.set_ability(ablity)


func _randomize_player_dice_point() -> void:
	for player in player_characters:
		player.dice_slot.roll_all_dice_slots()


func _randomize_enemy_dice_point() -> void:
	for enemy in enemy_characters:
		enemy.dice_slot.roll_all_dice_slots()


func _randomize_player_target() -> void:
	for player in player_characters:
		var player_slot_pool = player.get_dice_slot_pool()
		for dice_slot in player_slot_pool:
			var target_dice_slot = _get_random_enemy_dice_slot() as DiceSlotData
			dice_slot.set_target(target_dice_slot)


func _randomize_enemy_target() -> void:
	for enemy in enemy_characters:
		var enemy_slot_pool = enemy.get_dice_slot_pool()
		for dice_slot in enemy_slot_pool:
			var target_dice_slot = _get_random_player_dice_slot() as DiceSlotData
			dice_slot.set_target(target_dice_slot)


#region Helper
func _get_random_player_dice_slot() -> DiceSlotData:
	var random_player = player_characters.pick_random() as CharacterController
	var dice_slot = random_player.get_dice_slot_pool().pick_random() as DiceSlotData
	return dice_slot


func _get_random_enemy_dice_slot() -> DiceSlotData:
	var random_enemy = enemy_characters.pick_random() as CharacterController
	var dice_slot = random_enemy.get_dice_slot_pool().pick_random() as DiceSlotData
	return dice_slot
#endregion
