class_name AbilityView
extends Control

signal button_pressed(index: int)

@export var buttons: Array[AbilityButton] = []
var button_dict: Dictionary = {}


func initialize(targeting_data: TargetingData):
	initialize_children()
	targeting_data.player_slot_changed.connect(_on_player_slot_changed)
	targeting_data.enemy_slot_changed.connect(_on_enemy_slot_changed)
	self.hide()


func initialize_children():
	for i in range(buttons.size()):
		buttons[i].initialize(i)
		buttons[i].ability_button_pressed.connect(_on_button_pressed)


func _on_player_slot_changed(dice_slot: DiceSlotData):
	if dice_slot:
		var abilities: Array[AbilityData] = get_abilities_by_slot(dice_slot)
		update_buttons(abilities)
	else:
		update_buttons_to_default()


func _on_enemy_slot_changed(dice_slot: DiceSlotData):
	update_buttons_to_default()


func _on_button_pressed(index: int):
	button_pressed.emit(index)
	self.hide()


func update_buttons(abilities: Array[AbilityData]):
	for i in range(abilities.size()):
		buttons[i].update_icon(abilities[i].get_icon())


func update_buttons_to_default():
	for button in buttons:
		button.update_icon(null)


func get_abilities_by_slot(dice_slot: DiceSlotData):
	return dice_slot.owner_character.ability_controller.get_abilities()
