class_name AbilityView
extends Control

@export var buttons: Array[AbilityButton] = []

func _ready() -> void:
	initialize_children()
	self.hide()


func initialize_children():
	for i in range(buttons.size()):
		buttons[i].initialize(i)
		buttons[i].ability_button_pressed.connect(_on_button_pressed)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			_on_global_right_click()

func _on_global_right_click():
	EventBus.remove_ability_button_pressed.emit()

func _on_button_pressed(index: int):
	EventBus.ability_button_pressed.emit(index)


func update_button_icon(abilities: Array[AbilityData]):
	for i in range(buttons.size()):
		buttons[i].update_icon(abilities[i].get_icon())


func clear_ability_buttons_icon():
	for button in buttons:
		button.update_icon(null)


func get_abilities_by_slot(dice_slot: DiceSlotData):
	return dice_slot.get_owner().get_ability_controller().get_abilities()
