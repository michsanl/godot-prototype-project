class_name AbilityView
extends Control

@export var buttons: Array[AbilityButton] = []

func _ready() -> void:
	initialize_children()
	self.hide()


func initialize_children():
	for i in range(buttons.size()):
		buttons[i].initialize(i)


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
