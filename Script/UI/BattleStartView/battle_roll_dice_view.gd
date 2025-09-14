class_name StrategyView
extends Control

enum ButtonState { ROLL, COMBAT }

signal roll_button_pressed
signal combat_button_pressed

@export var button_panel: Panel
@export var count_panel: Panel
@export var count_label: Label

var _button_state: ButtonState = ButtonState.ROLL

func set_button_panel_visibility(condition: bool):
	button_panel.visible = condition

func set_count_panel_visibility(condition: bool):
	count_panel.visible = condition

func set_count_label_text(new_text: String):
	count_label.text = new_text

func _on_start_button_pressed() -> void:
	match _button_state:
		ButtonState.ROLL:
			roll_button_pressed.emit()
			_button_state = ButtonState.COMBAT
		ButtonState.COMBAT:
			combat_button_pressed.emit()
			_button_state = ButtonState.ROLL
