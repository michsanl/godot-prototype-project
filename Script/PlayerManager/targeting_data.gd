class_name TargetingData
extends RefCounted

enum TargetingState { NONE_SELECTED, SLOT_SELECTED, ABILITY_SELECTED }

signal player_slot_changed(dice_slot: DiceSlotData)
signal enemy_slot_changed(dice_slot: DiceSlotData)

var selected_player_slot: DiceSlotData
var selected_enemy_slot: DiceSlotData
var selected_ability: AbilityData
var state: TargetingState


func set_player_selected_slot(new_slot: DiceSlotData):
	selected_player_slot = new_slot
	player_slot_changed.emit(new_slot)


func set_enemy_selected_slot(new_slot: DiceSlotData):
	selected_enemy_slot = new_slot
	enemy_slot_changed.emit(new_slot)


func set_selected_ability(new_ability: AbilityData):
	selected_ability = new_ability


func clear_targeting_properties():
	selected_player_slot = null
	selected_enemy_slot = null
	selected_ability = null
