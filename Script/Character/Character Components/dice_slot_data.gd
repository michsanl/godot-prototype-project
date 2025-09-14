class_name DiceSlotData
extends RefCounted

enum DiceSlotState { INACTIVE, ACTIVE, HIGHLIGHT, STUNNED }

signal state_changed(new_state: String)
signal target_slot_changed(new_target: DiceSlotData)
signal selected_ability_changed(new_ability: AbilityData)
signal speed_value_changed(new_value: int)

var owner_character: CharacterController
var state: DiceSlotState
var min_speed_value: int
var max_speed_value: int
var speed_value: int
var target_dice_slot: DiceSlotData
var selected_ability: AbilityData
var view: DiceSlotView


func initialize(new_owner, min_speed, max_speed, new_view):
	owner_character = new_owner
	min_speed_value = min_speed
	max_speed_value = max_speed
	view = new_view


func activate():
	set_state(DiceSlotState.ACTIVE)


func deactivate():
	set_state(DiceSlotState.INACTIVE)


func clear_data():
	set_speed_value(0)
	set_target_slot(null)
	set_selected_ability(null)


func roll_speed_value():
	speed_value = randi_range(min_speed_value, max_speed_value)
	speed_value_changed.emit(speed_value)


func set_speed_value(new_value: int):
	speed_value = new_value
	speed_value_changed.emit(speed_value)


func set_target_slot(new_target: DiceSlotData):
	if target_dice_slot != new_target:
		target_dice_slot = new_target
		target_slot_changed.emit(new_target)


func set_selected_ability(new_ability: AbilityData):
	if selected_ability != new_ability:
		selected_ability = new_ability
		selected_ability_changed.emit(new_ability)


func set_state(new_state: int):
	if state != new_state:
		state = new_state
		state_changed.emit(new_state)
