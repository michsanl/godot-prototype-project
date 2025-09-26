class_name CharacterCombatController
extends Control

@export var facing_left: bool
@export var slot_controller: DiceSlotController
@export var ability_controller: CharacterAbilityController
@export var view_face_right: CharacterCombatView
@export var view_face_left: CharacterCombatView

var view: CharacterCombatView
var roll_value: int
var front_die: BaseDice
var active_dice: Array[BaseDice] = []
var reserved_dice: Array[BaseDice] = []
var selected_ability: AbilityData
var selected_slot: DiceSlotData


func _ready() -> void:
	if facing_left:
		view = view_face_left
	else:
		view = view_face_right
		
	view_face_right.hide()
	view_face_left.hide()


func initialize_combat(source_dice_slot: DiceSlotData):
	selected_slot = source_dice_slot
	selected_ability = source_dice_slot.get_selected_ability()
	
	active_dice.append_array(selected_ability.get_dice_pool())
	active_dice.append_array(reserved_dice)
	
	front_die = active_dice[0]
	
	view.update_icons(active_dice)
	view.show()


func finalize_combat():
	active_dice.clear()
	reserved_dice.clear()
	front_die = null
	selected_slot = null
	selected_ability = null
	
	view.hide()


func roll_front_die():
	if front_die == null: 
		return
	roll_value = front_die.get_roll_value()
	
	view.update_front_icon_post_roll(roll_value)


func pop_front_die():
	if active_dice.is_empty():
		return
	active_dice.pop_front()
	
	view.update_icons(active_dice)


func update_front_dice():
	if active_dice:
		front_die = active_dice[0]
		view.update_front_icon_pre_roll(front_die)


func has_dice() -> bool:
	return not active_dice.is_empty()


func get_roll_value() -> int:
	return roll_value


func get_front_die() -> BaseDice:
	return front_die
