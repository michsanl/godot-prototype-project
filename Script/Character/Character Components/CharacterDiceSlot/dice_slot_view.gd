class_name DiceSlotView
extends Control

signal right_mouse_hover_pressed(index: int)
signal left_mouse_hover_pressed(index: int)
signal mouse_hover_entered(index: int)
signal mouse_hover_exited(index: int)

var index: int


func initialize(new_index: int):
	index = new_index
	hide()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			left_mouse_hover_pressed.emit(index)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			right_mouse_hover_pressed.emit(index)


func _on_mouse_entered() -> void:
	mouse_hover_entered.emit(index)


func _on_mouse_exited() -> void:
	mouse_hover_exited.emit(index)


func update_speed_value(new_text: String):
	$ValueLabel.text = new_text


func update_target_trajectory(target_pos: Vector2):
	if target_pos != Vector2.ZERO:
		$Trajectory.draw_trajectory(target_pos)
	else:
		$Trajectory.clear_trajectory()


func update_mouse_trajectory(condition: bool):
	$Trajectory.set_trajectory_to_mouse(condition)


func update_highlight(condition: bool):
	if condition:
		$Icon.modulate = Color(1, 1, 0.5)
	else:
		$Icon.modulate = Color(1, 1, 1) 


func update_visibility(condition: bool):
	if condition:
		show()
	else:
		hide()
