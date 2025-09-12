class_name StrategyStateManager
extends Node

@export var player_characters: Array[CharacterController]
@export var enemy_characters: Array[CharacterController]

var _player_dice_slots: Array[DiceSlotData]
var _enemy_dice_slots: Array[DiceSlotData]

func handle_strategy_state_enter() -> void:
	_gather_character_active_dice_slots(player_characters, _player_dice_slots)
	_gather_character_active_dice_slots(enemy_characters, _enemy_dice_slots)
	_roll_character_dice_slot(_player_dice_slots)
	_roll_character_dice_slot(_enemy_dice_slots)
	_randomize_character_dice_slot_ability(_player_dice_slots)
	_randomize_character_dice_slot_ability(_enemy_dice_slots)
	_randomize_character_target(_player_dice_slots, _enemy_dice_slots)
	_randomize_character_target(_enemy_dice_slots, _player_dice_slots)


func handle_strategy_state_exit() -> void:
	pass


func _gather_character_active_dice_slots(characters: Array[CharacterController], slots: Array[DiceSlotData]):
	for character in characters:
		var dice_slots = character.dice_slot_controller.dice_slots
		for dice_slot in dice_slots:
			if dice_slot.state == DiceSlotData.DiceSlotState.ACTIVE:
				slots.append(dice_slot)


func _roll_character_dice_slot(slots: Array[DiceSlotData]):
	for slot in slots:
		slot.roll_speed_value()


func _randomize_character_dice_slot_ability(slots: Array[DiceSlotData]):
	for slot in slots:
		var ability = slot.owner_character.ability_controller.ability_list.pick_random()
		slot.set_selected_ability(ability)


func _randomize_player_dice_point() -> void:
	for player in player_characters:
		player.dice_slot.roll_all_dice_slots()


func _randomize_enemy_dice_point() -> void:
	for enemy in enemy_characters:
		enemy.dice_slot.roll_all_dice_slots()


func _randomize_character_target(actor_slots: Array[DiceSlotData], opponent_slots: Array[DiceSlotData]):
	for actor_slot in actor_slots:
		actor_slot.target_dice_slot = opponent_slots.pick_random()


#func _randomize_player_target() -> void:
	#for player in player_characters:
		#var player_slot_pool = player.dice_slot_controller.get_active_dice_slots()
		#for dice_slot in player_slot_pool:
			#var target_dice_slot = _get_random_enemy_dice_slot() as DiceSlotData
			#dice_slot.set_target_slot(target_dice_slot)
#
#
#func _randomize_enemy_target() -> void:
	#for enemy in enemy_characters:
		#var enemy_slot_pool = enemy.dice_slot_controller.get_active_dice_slots()
		#for dice_slot in enemy_slot_pool:
			#var target_dice_slot = _get_random_player_dice_slot() as DiceSlotData
			#dice_slot.set_target_slot(target_dice_slot)
#
#
##region Helper
#func _get_random_player_dice_slot() -> DiceSlotData:
	#var random_player = player_characters.pick_random() as CharacterController
	#var dice_slot = random_player.get_dice_slot_pool().pick_random() as DiceSlotData
	#return dice_slot
#
#
#func _get_random_enemy_dice_slot() -> DiceSlotData:
	#var random_enemy = enemy_characters.pick_random() as CharacterController
	#var dice_slot = random_enemy.get_dice_slot_pool().pick_random() as DiceSlotData
	#return dice_slot
##endregion
