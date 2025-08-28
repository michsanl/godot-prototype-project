class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterBase] = []
@export var enemy_characters: Array[CharacterBase] = []


func handle_strategy_state_enter() -> void:
	_randomize_player_target()
	_randomize_enemy_target()


func handle_strategy_state_exit() -> void:
	_clear_player_aim_target()
	_clear_enemy_aim_target()


func _randomize_player_dice_point() -> void:
	for player in player_characters:
		player.dice_slot_controller.roll_all_dice_slot()


func _randomize_enemy_dice_point() -> void:
	for enemy in enemy_characters:
		enemy.dice_slot_controller.roll_all_dice_slot()


func _randomize_player_target() -> void:
	for player in player_characters:
		var dice_slot_pool = _get_character_dice_slot_pool(player)
		for dice_slot in dice_slot_pool:
			var target_dice_slot = _get_random_enemy_dice_slot() as CharacterDiceSlot
			dice_slot.set_target_dice_slot(target_dice_slot)
			
		# NOTE: Old method
		var target: CharacterBase = enemy_characters.pick_random()
		player.set_target(target)
		player.set_aim_target(target)


func _randomize_enemy_target() -> void:
	for enemy in enemy_characters:
		var dice_slot_pool = _get_character_dice_slot_pool(enemy)
		for dice_slot in dice_slot_pool:
			var target_dice_slot = _get_random_player_dice_slot() as CharacterDiceSlot
			dice_slot.set_target_dice_slot(target_dice_slot)
			
		# NOTE: Old method
		var target: CharacterBase = player_characters.pick_random()
		enemy.set_target(target)
		enemy.set_aim_target(target)


func _clear_player_aim_target() -> void:
	for player in player_characters:
		player.remove_aim_target()


func _clear_enemy_aim_target() -> void:
	for enemy in enemy_characters:
		enemy.remove_aim_target()



#region Helper
func _get_character_dice_slot_pool(character: CharacterBase) -> Array[CharacterDiceSlot]:
	return character.dice_slot_controller.get_dice_slot_pool()


func _get_random_player_dice_slot() -> CharacterDiceSlot:
	var random_player = player_characters.pick_random() as CharacterBase
	var dice_slot = random_player.dice_slot_controller.get_random_dice_slot()
	return dice_slot


func _get_random_enemy_dice_slot() -> CharacterDiceSlot:
	var random_enemy = enemy_characters.pick_random() as CharacterBase
	var dice_slot = random_enemy.dice_slot_controller.get_random_dice_slot()
	return dice_slot
#endregion
