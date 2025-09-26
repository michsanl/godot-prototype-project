class_name CharacterCombatController
extends Control

# FLOW: 

signal roll_value_changed(new_value: int)
signal dice_list_changed(dice: Array[BaseDice])
signal front_die_changed(die: BaseDice)
signal combat_initialized(dice: Array[BaseDice])
signal combat_finalized

@export var slot_controller: DiceSlotController
@export var ability_controller: CharacterAbilityController

var roll_value: int
var front_die: BaseDice
var active_dice: Array[BaseDice] = []
var reserved_dice: Array[BaseDice] = []
var selected_ability: AbilityData
var selected_slot: DiceSlotData

func initialize_combat(source_dice_slot: DiceSlotData):
	selected_slot = source_dice_slot
	selected_ability = source_dice_slot.get_selected_ability()
	print(selected_ability)
	active_dice.append_array(selected_ability.get_dice_pool())
	active_dice.append_array(reserved_dice)
	front_die = active_dice[0]
	
	combat_initialized.emit(active_dice)


func finalize_combat():
	front_die = null
	selected_slot = null
	selected_ability = null
	reserved_dice.clear()
	reserved_dice.append_array(active_dice)
	active_dice.clear()
	
	combat_finalized.emit()

func roll_front_die():
	roll_value = front_die.get_roll_value()
	roll_value_changed.emit(roll_value)


func pop_front_die():
	active_dice.pop_front()
	dice_list_changed.emit(active_dice)


func update_front_dice():
	if active_dice:
		front_die = active_dice[0]
		front_die_changed.emit(front_die)


func has_dice() -> bool:
	return not active_dice.is_empty()


func get_roll_value() -> int:
	return roll_value


func get_front_die() -> BaseDice:
	return front_die
