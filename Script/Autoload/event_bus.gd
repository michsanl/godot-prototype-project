extends Node

enum SlotAction {
	LEFT_MOUSE_PRESSED,
	RIGHT_MOUSE_PRESSED,
	HOVER_ENTERED,
	HOVER_EXITED
}

@warning_ignore("unused_signal")
signal ability_button_pressed(index: int)
@warning_ignore("unused_signal")
signal remove_ability_button_pressed
@warning_ignore("unused_signal")
signal slot_inputs(source: DiceSlotController, index: int, SlotAction: int)
