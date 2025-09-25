extends Node

enum SlotAction {
	LEFT_MOUSE_PRESSED,
	RIGHT_MOUSE_PRESSED,
	HOVER_ENTERED,
	HOVER_EXITED
}

signal ability_button_pressed(index: int)
signal remove_ability_button_pressed

signal slot_inputs(source: DiceSlotController, index: int, SlotAction: int)

signal enemy_slot_left_mouse_pressed(controller: DiceSlotController, index: int)
signal enemy_slot_focus_exited(controller: DiceSlotController, index: int)
signal enemy_slot_hover_entered(controller: DiceSlotController, index: int)
signal enemy_slot_hover_exited(controller: DiceSlotController, index: int)

signal enemy_focus_selection_added(controller: DiceSlotController, index: int)
signal enemy_focus_selection_removed(controller: DiceSlotController, index: int)
signal enemy_highlight_selection_added(controller: DiceSlotController, index: int)
signal enemy_highlight_selection_removed(controller: DiceSlotController, index: int)
