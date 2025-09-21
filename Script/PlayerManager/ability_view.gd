class_name AbilityView
extends Node

signal button_pressed(index: int)

@export var buttons: Array[AbilityButton] = []
var button_dict: Dictionary = {}

func _ready() -> void:
	for i in range(buttons.size()):
		buttons[i].initialize(i)
		buttons[i].button_pressed.connect(handle_button_press)

func update_buttons(abilities: Array[AbilityData]):
	for i in range(abilities.size()):
		buttons[i].update_icon(abilities[i].get_icon())


func update_buttons_to_default():
	for button in buttons:
		button.update_icon(button.default_icon)


func handle_button_press(index: int):
	print("Button ", index, " was pressed")
	button_pressed.emit(index)


func setup_button_index():
	for i in range(buttons.size()):
		var index := i
		buttons[i].connect("pressed", Callable(self, "handle_button_press").bind(index))
