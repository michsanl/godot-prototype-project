class_name PlayerSlotController
extends DiceSlotController

func _on_left_mouse_hover_pressed(index: int):
	focus_slot(index)
	EventBus.slot_left_mouse_pressed.emit(self, index)


func _on_right_mouse_hover_pressed(index: int):
	unfocus_slot(index)
	EventBus.slot_focus_exited.emit(self, index)


func _on_mouse_hover_entered(index: int):
	highlight_slot(index)
	EventBus.slot_hover_entered.emit(self, index)


func _on_mouse_hover_exited(index: int):
	unhighlight_slot(index)
	EventBus.slot_hover_exited.emit(self, index)


func _on_current_focus_slot_selected(index: int):
	focus_slot(index)


func _on_current_focus_slot_removed(index: int):
	unfocus_slot(index)
