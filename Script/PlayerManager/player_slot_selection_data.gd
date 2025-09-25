class_name PlayerSlotSelectionData
extends RefCounted

var focused_slot_controller: DiceSlotController
var highlighted_slot_controller: DiceSlotController
var focused_slot_index: int
var highlighted_slot_index: int

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


func set_focused_slot_controller(controller: DiceSlotController):
	focused_slot_controller = controller
	print("Focused controller: ", controller)


func set_focused_slot_index(index: int):
	focused_slot_index = index
	print("Focused slot: ", index)


func set_highlighted_slot_controller(controller: DiceSlotController):
	highlighted_slot_controller = controller
	print("Focused controller: ", controller)


func set_highlighted_slot_index(index: int):
	highlighted_slot_index = index
	print("Focused slot: ", index)
	
