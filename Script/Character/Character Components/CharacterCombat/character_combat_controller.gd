class_name CharacterCombatController
extends Node

@export var slot_controller: DiceSlotController
@export var ability_controller: CharacterAbilityController
@export var view: CharacterCombatView

var roll_value: int
var front_die: BaseDice
var active_dice: Array[BaseDice] = []
var reserved_dice: Array[BaseDice] = []
var selected_ability: AbilityData
var selected_slot: DiceSlotData

func _ready() -> void:
	view.hide()


func initialize_combat(source_dice_slot: DiceSlotData, dir: Vector2):
	selected_slot = source_dice_slot
	selected_ability = source_dice_slot.get_selected_ability()
	
	active_dice.append_array(selected_ability.get_dice_pool())
	active_dice.append_array(reserved_dice)
	
	front_die = active_dice[0]
	
	view.update_facing(dir)
	view.update_icons(active_dice)
	view.show()


func finalize_combat():
	active_dice.clear()
	reserved_dice.clear()
	front_die = null
	selected_slot = null
	selected_ability = null
	
	view.hide()


func pop_front_die():
	if active_dice.is_empty():
		return
	active_dice.pop_front()
	
	view.update_icons(active_dice)


func roll_front_die():
	if front_die == null: 
		return
	roll_value = front_die.get_roll_value()
	
	view.update_roll_label(0, roll_value)
	view.update_roll_label_visibility(0, true)
	view.update_icon_texture_visibility(0, false)


func update_front_dice():
	if active_dice:
		front_die = active_dice[0]
		var min_val = front_die.get_min_val()
		var max_val = front_die.get_max_val()
		
		view.update_range_label(0, min_val, max_val)
		view.update_range_label_visibility(0, true)
		view.update_roll_label_visibility(0, false)


func has_dice() -> bool:
	return not active_dice.is_empty()


func get_roll_value() -> int:
	return roll_value


func get_front_die() -> BaseDice:
	return front_die
