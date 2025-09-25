class_name DiceSlotView
extends Control

signal slot_inputs(source_index: int, SlotAction: int)

var index: int


func initialize(new_index: int):
	index = new_index


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			slot_inputs.emit(index, SlotActions.Action.LEFT_MOUSE_PRESSED)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			slot_inputs.emit(index, SlotActions.Action.RIGHT_MOUSE_PRESSED)


func _on_mouse_entered() -> void:
	slot_inputs.emit(index, SlotActions.Action.HOVER_ENTERED)


func _on_mouse_exited() -> void:
	slot_inputs.emit(index, SlotActions.Action.HOVER_EXITED)


func clear_all():
	update_focus(false)
	update_highlight(false)
	update_target_lock(false)
	update_mouse_trajectory(false)
	update_target_trajectory(Vector2.ZERO)


func update_speed_value(new_text: String):
	$ValueLabel.text = new_text


func update_highlight(condition: bool):
	if condition:
		$HighlightIcon.show()
	else:
		$HighlightIcon.hide()


func update_focus(condition: bool):
	if condition:
		$FocusIcon.show()
	else:
		$FocusIcon.hide()


func update_target_lock(condition: bool):
	if condition:
		$TargetSetIcon.show()
	else:
		$TargetSetIcon.hide()


func update_target_trajectory(target_pos: Vector2):
	if target_pos != Vector2.ZERO:
		$Trajectory.draw_trajectory(target_pos)
	else:
		$Trajectory.clear_trajectory()


func update_mouse_trajectory(condition: bool):
	if condition:
		$Trajectory.set_trajectory_to_mouse(condition)
	else:
		$Trajectory.set_trajectory_to_mouse(condition)
		$Trajectory.clear_trajectory()


func update_visibility(condition: bool):
	if condition:
		show()
	else:
		hide()
