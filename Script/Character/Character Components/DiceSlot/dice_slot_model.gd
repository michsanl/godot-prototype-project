class_name DiceSlotModel 
extends Node

enum DiceSlotState { ACTIVE, HIGHLIGHT, STUNNED, DISABLED }

signal speed_value_changed(new_value: int)
signal state_changed(new_state: String)
signal target_slot_changed(new_target: DiceSlotModel)
signal selected_ability_changed(new_ability: AbilityData)

var owner_character: CharacterController
var state: DiceSlotState
var speed_value: int = 0
var target_slot: DiceSlotModel
var selected_ability: AbilityData


func initialize(new_owner):
	owner_character = new_owner


func set_speed_value(new_value: int):
	if speed_value != new_value:
		speed_value = new_value
		speed_value_changed.emit(new_value)


func set_state(new_state: int):
	if state != new_state:
		state = new_state
		state_changed.emit(new_state)


func set_target_slot(new_target: DiceSlotModel):
	if target_slot != new_target:
		target_slot = new_target
		target_slot_changed.emit(new_target)


func set_selected_ability(new_ability: AbilityData):
	if selected_ability != new_ability:
		selected_ability = new_ability
		selected_ability_changed.emit(new_ability)
