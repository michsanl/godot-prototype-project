class_name CharacterDiceSlot
extends Node

@export var min_speed_value: int = 1
@export var max_speed_value: int = 10

var speed_value: int
var owner_character: CharacterBase
var target_dice_slot: CharacterDiceSlot
var selected_ability: AbilityData


func roll_speed():
	speed_value = randi_range(min_speed_value, max_speed_value)


func set_owner_character(owner: CharacterBase):
	owner_character = owner


func set_target_dice_slot(target: CharacterDiceSlot):
	target_dice_slot = target


func set_selected_ability(ability: AbilityData):
	selected_ability = ability
