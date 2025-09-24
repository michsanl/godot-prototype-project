class_name TargetingData
extends RefCounted

enum TargetingState { NONE_SELECTED, SLOT_SELECTED, ABILITY_SELECTED }

signal highlighted_slot_changed(dice_slot: DiceSlotData)
signal focused_slot_changed(dice_slot: DiceSlotData)
signal selected_ability_changed(ability: AbilityData)

var highlighted_slot: DiceSlotData
var focused_slot: DiceSlotData
var selected_ability: AbilityData
var state: TargetingState


func set_highlighted_slot(new_slot: DiceSlotData):
	highlighted_slot = new_slot
	highlighted_slot_changed.emit(new_slot)
	print("Highlighted slot: ", new_slot)


func set_focused_slot(new_slot: DiceSlotData):
	focused_slot = new_slot
	focused_slot_changed.emit(new_slot)
	print("Focused slot: ", new_slot)


func set_selected_ability(new_ability: AbilityData):
	selected_ability = new_ability
	selected_ability_changed.emit(new_ability)
	print("Selected ability: ", new_ability)


func clear_targeting_properties():
	highlighted_slot = null
	focused_slot = null
	selected_ability = null
	
	selected_ability_changed.emit(null)
	focused_slot_changed.emit(null)
	highlighted_slot_changed.emit(null)
	
