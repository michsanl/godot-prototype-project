class_name DiceSlotController
extends Control

signal selected_slot_changed(dice_slot: DiceSlotData)

@export var views: Array[DiceSlotView] = []

var dice_slots: Array[DiceSlotData] = []
var owner_character: CharacterController
var min_speed_value: int
var max_speed_value: int
var selected_dice_slot: DiceSlotData

func initialize(new_owner, starting_slot_amount, min_value = 1, max_value = 10):
	owner_character = new_owner
	max_speed_value = max_value
	min_speed_value = min_value
	
	for view in views:
		view.button_pressed.connect(_on_view_button_pressed)
	
	_initialize_models()
	_initialize_views()
	
	for i in range(starting_slot_amount):
		activate_dice_slot(i)


func set_visibility(condition: bool):
	self.visible = condition


func roll_dice_slot(index: int):
	dice_slots[index].roll_speed_value()


func activate_dice_slot(index: int):
	dice_slots[index].activate()


func get_dice_slot(index: int) -> DiceSlotData:
	return dice_slots[index]


func deactivate_dice_slot(index: int):
	dice_slots[index].deactivate()


func set_dice_slot_target(index: int, target: DiceSlotData):
	dice_slots[index].set_target_slot(target)


func set_dice_slot_ability(index: int, ability: AbilityData):
	dice_slots[index].set_selected_ability(ability)


func clear_all_dice_slot_data():
	for dice_slot in dice_slots:
		if dice_slot.state != DiceSlotData.DiceSlotState.ACTIVE:
			break
		dice_slot.clear_data()


func _initialize_models():
	dice_slots.resize(len(views))
	
	for i in range(len(dice_slots)):
		dice_slots[i] = DiceSlotData.new()
		dice_slots[i].initialize(owner_character, min_speed_value, max_speed_value, views[i])


func _initialize_views():
	for i in range(len(dice_slots)):
		views[i].initialize(dice_slots[i], i)


func _on_view_button_pressed(new_index: int) -> void:
	selected_dice_slot = get_dice_slot(new_index)
	selected_slot_changed.emit(selected_dice_slot)
