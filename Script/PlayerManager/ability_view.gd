class_name AbilityView
extends Control

signal ability_button_pressed(index: int)

@export var buttons: Array[AbilityButton] = []
var button_dict: Dictionary = {}


func initialize():
	initialize_children()
	self.hide()


func initialize_children():
	for i in range(buttons.size()):
		buttons[i].initialize(i)
		buttons[i].ability_button_pressed.connect(_on_button_pressed)


func _on_button_pressed(index: int):
	ability_button_pressed.emit(index)
	self.hide()


func update_ability_buttons_icon(abilities: Array[AbilityData]):
	for i in range(abilities.size()):
		buttons[i].update_icon(abilities[i].get_icon())


func clear_ability_buttons_icon():
	for button in buttons:
		button.update_icon(null)


func get_abilities_by_slot(dice_slot: DiceSlotData):
	return dice_slot.get_owner().get_ability_controller().get_abilities()
