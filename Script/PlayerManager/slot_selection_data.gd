class_name SlotSelectionData
extends RefCounted

var ability_data: AbilityData
var focused_slot_controller: DiceSlotController
var highlighted_slot_controller: DiceSlotController
var target_slot_controller: DiceSlotController
var focused_slot_index: int
var highlighted_slot_index: int
var target_slot_index: int


func _init(
	focused_contr = null,
	highlighted_contr = null,
	focused_index = -1,
	highlighted_index = -1,
) -> void:
	focused_slot_controller = focused_contr
	highlighted_slot_controller = highlighted_contr
	focused_slot_index = focused_index
	highlighted_slot_index = highlighted_index


func set_focused_slot(controller: DiceSlotController, index: int):
	focused_slot_controller = controller
	focused_slot_index = index
	Debug.log("Focus set.")


func clear_focus():
	focused_slot_controller = null
	focused_slot_index = -1


func set_highlighted_slot(controller: DiceSlotController, index: int):
	highlighted_slot_controller = controller
	highlighted_slot_index = index


func clear_highlight():
	highlighted_slot_controller = null
	highlighted_slot_index = -1


func set_slot_ability(ability: AbilityData):
	ability_data = ability
	Debug.log("Ability set.")


func clear_ability():
	ability_data = null


func clear_target():
	target_slot_controller = null
	target_slot_index = -1


func reset():
	clear_focus()
	clear_highlight()
	clear_ability()
	clear_target()


func has_focus() -> bool:
	return focused_slot_controller != null and focused_slot_index >= 0


func has_ability() -> bool:
	return ability_data != null
