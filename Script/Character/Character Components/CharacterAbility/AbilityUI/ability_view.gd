class_name AbilityView
extends Node

signal button_pressed(index: int)

@export var buttons: Array[Button] = []
var button_dict: Dictionary = {}

func _ready() -> void:
	setup_button_index()

func setup_button_index():
	for i in range(buttons.size()):
		var index := i
		buttons[i].connect("pressed", Callable(self, "handle_button_press").bind(index))

func handle_button_press(index: int):
	print("Button ", index, " was pressed")
	button_pressed.emit()
