class_name DiceControl
extends Control

@export var dice_slots: Array[DiceSlotModel] = []
@export var views: Array[DiceSlotView] = []

var owner_character: CharacterController
var min_speed_value: int
var max_speed_value: int


func initialize(new_owner, min_value, max_value):
	max_speed_value = max_value
	min_speed_value = min_value
	owner_character = new_owner
	_deactivate_all_dice_slot()
	activate_dice_slot(0)
	activate_dice_slot(1)


func roll_active_dice_slot():
	for dice_slot in dice_slots:
		if dice_slot.state == DiceSlotModel.DiceSlotState.ACTIVE:
			var speed_value: int = _get_roll_value()
			dice_slot.set_speed_value(speed_value)


func activate_dice_slot(index: int):
	dice_slots[index].set_state(DiceSlotModel.DiceSlotState.ACTIVE)


func _deactivate_all_dice_slot():
	for dice_slot in dice_slots:
		dice_slot.set_state(DiceSlotModel.DiceSlotState.DISABLED)


func _get_roll_value() -> int:
	return randi_range(min_speed_value, max_speed_value)
