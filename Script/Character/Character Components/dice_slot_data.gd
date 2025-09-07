class_name DiceSlotData
extends Node

signal target_added
signal target_removed

var owner_character: CharacterController
var speed_value: int
var target_dice_slot: DiceSlotData
var selected_ability: AbilityData
var min_speed_value: int = 1
var max_speed_value: int = 10


func roll_speed_value():
	speed_value = randi_range(min_speed_value, max_speed_value)


func clear_target_dice_slot():
	target_dice_slot = null
	target_removed.emit()


#region Setter
func set_dice_slot_owner(new_owner: CharacterController):
	owner_character = new_owner


func set_target(dice_slot: DiceSlotData):
	target_dice_slot = dice_slot
	target_added.emit()


func set_ability(ability: AbilityData):
	selected_ability = ability
#endregion
