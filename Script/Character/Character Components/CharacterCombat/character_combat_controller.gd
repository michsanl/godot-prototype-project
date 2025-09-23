class_name CharacterCombatController
extends Control

# FLOW: 

signal roll_value_changed(new_value: int)
signal dice_list_changed(dice: Array[IDice])
signal front_die_changed(die: IDice)

@export var slot_controller: DiceSlotController
@export var ability_controller: CharacterAbilityController

var roll_value: int
var front_die: IDice
var active_dice: Array[IDice] = []
var reserved_dice: Array[IDice] = []
var selected_ability: AbilityData
var selected_slot: DiceSlotData

func initialize_combat(source_dice_slot: DiceSlotData):
	selected_slot = source_dice_slot
	selected_ability = source_dice_slot.get_selected_ability()
	
	active_dice.append_array(selected_ability.get_dice_pool())
	active_dice.append_array(reserved_dice)
	
	front_die = active_dice[0]
	
	roll_value_changed.emit(roll_value)
	dice_list_changed.emit(active_dice)
	front_die_changed.emit(front_die)


func roll_front_die():
	roll_value = front_die.get_roll_value()
	roll_value_changed.emit(roll_value)


func pop_front_die():
	active_dice.pop_front()
	_update_front_dice()
	dice_list_changed.emit(active_dice)


func has_dice() -> bool:
	return not active_dice.is_empty()


func get_roll_value() -> int:
	return roll_value


func get_front_die() -> IDice:
	return front_die


func _update_front_dice():
	if active_dice:
		front_die = active_dice[0]
		front_die_changed.emit(front_die)
