class_name CharacterDiceSlot
extends Node

signal target_added
signal target_removed

@export var min_speed_value: int = 1
@export var max_speed_value: int = 10

var speed_value: int
var owner_character: CharacterController
var target_dice_slot: CharacterDiceSlot
var selected_ability: AbilityData


func roll_speed_value():
	speed_value = randi_range(min_speed_value, max_speed_value)


#region Setter
func set_owner_character(owner_char: CharacterController):
	self.owner_character = owner_char


func set_target(dice_slot: CharacterDiceSlot):
	target_dice_slot = dice_slot
	target_added.emit()


func set_ability(ability: AbilityData):
	selected_ability = ability
#endregion


func clear_target_dice_slot():
	target_dice_slot = null
	target_removed.emit()
