class_name DiceSlotData
extends RefCounted

enum DiceSlotState { 
	DEFAULT, HIGHLIGHT, FOCUS, AIM, TARGET_SET, INACTIVE 
}

signal state_changed(new_state: String)
signal target_slot_changed(new_target: DiceSlotData)
signal selected_ability_changed(new_ability: AbilityData)
signal speed_value_changed(new_value: int)

var owner_unit: CharacterController
var state: DiceSlotState
var speed_value: int = 0
var target_dice_slot: DiceSlotData
var selected_ability: AbilityData


func initialize(new_owner):
	owner_unit = new_owner


func set_speed_value(new_value: int):
	speed_value = new_value
	speed_value_changed.emit(new_value)


func set_target_slot(new_target: DiceSlotData):
	target_dice_slot = new_target
	target_slot_changed.emit(new_target)
	print(self, " setting target: ", new_target)


func set_selected_ability(new_ability: AbilityData):
	selected_ability = new_ability
	selected_ability_changed.emit(new_ability)


func set_state(new_state: DiceSlotState):
	state = new_state
	match state:
		DiceSlotState.DEFAULT:
			pass
		DiceSlotState.HIGHLIGHT:
			pass
		DiceSlotState.FOCUS:
			pass
		DiceSlotState.AIM:
			pass
		DiceSlotState.DEFAULT:
			pass
			
	state_changed.emit(new_state)


func clear_data():
	speed_value = 0
	set_target_slot(null)
	set_selected_ability(null)


func get_owner() -> CharacterController:
	return owner_unit


func get_owner_global_position() -> Vector2:
	return owner_unit.global_position


func get_selected_ability() -> AbilityData:
	return selected_ability
