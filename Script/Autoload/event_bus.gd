extends Node

signal ability_button_pressed(index: int)
signal remove_ability_button_pressed

signal focus_selection_added(controller: DiceSlotController, index: int)
signal focus_selection_removed(controller: DiceSlotController, index: int)
signal highlight_selection_added(controller: DiceSlotController, index: int)
signal highlight_selection_removed(controller: DiceSlotController, index: int)

@warning_ignore("unused_signal")
signal slot_focus_entered(controller: DiceSlotController, index: int)
@warning_ignore("unused_signal")
signal slot_focus_exited(controller: DiceSlotController, index: int)
@warning_ignore("unused_signal")
signal slot_highlight_entered(controller: DiceSlotController, index: int)
@warning_ignore("unused_signal")
signal slot_highlight_exited(controller: DiceSlotController, index: int)
