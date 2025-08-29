class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterController] = []
@export var enemy_characters: Array[CharacterController] = []


func handle_strategy_state_enter() -> void:
	_randomize_player_target()
	_randomize_enemy_target()


func handle_strategy_state_exit() -> void:
	_clear_player_aim_target()
	_clear_enemy_aim_target()


func _randomize_player_dice_point() -> void:
	for player in player_characters:
		player.dice_slot.roll_all_dice_slot()


func _randomize_enemy_dice_point() -> void:
	for enemy in enemy_characters:
		enemy.dice_slot.roll_all_dice_slot()


func _randomize_player_target() -> void:
	for player in player_characters:
		var player_slot_pool = player.get_dice_slot_pool()
		for dice_slot in player_slot_pool:
			var target_dice_slot = _get_random_enemy_dice_slot() as CharacterDiceSlot
			dice_slot.set_target_dice_slot(target_dice_slot)
			
		# NOTE: Old method
		var target: CharacterController = enemy_characters.pick_random()
		player.set_target(target)
		player.set_aim_target(target)


func _randomize_enemy_target() -> void:
	for enemy in enemy_characters:
		var enemy_slot_pool = enemy.get_dice_slot_pool()
		for dice_slot in enemy_slot_pool:
			var target_dice_slot = _get_random_player_dice_slot() as CharacterDiceSlot
			dice_slot.set_target_dice_slot(target_dice_slot)
			
		# NOTE: Old method
		var target: CharacterController = player_characters.pick_random()
		enemy.set_target(target)
		enemy.set_aim_target(target)


func _clear_player_aim_target() -> void:
	for player in player_characters:
		player.remove_aim_target()


func _clear_enemy_aim_target() -> void:
	for enemy in enemy_characters:
		enemy.remove_aim_target()



#region Helper
func _get_random_player_dice_slot() -> CharacterDiceSlot:
	var random_player = player_characters.pick_random() as CharacterController
	var dice_slot = random_player.get_dice_slot_pool().pick_random() as CharacterDiceSlot
	return dice_slot


func _get_random_enemy_dice_slot() -> CharacterDiceSlot:
	var random_enemy = enemy_characters.pick_random() as CharacterController
	var dice_slot = random_enemy.get_dice_slot_pool().pick_random() as CharacterDiceSlot
	return dice_slot
#endregion
