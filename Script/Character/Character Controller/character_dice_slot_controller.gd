class_name CharacterDiceSlotController
extends Node

@export var dice_slot_views: Array[DiceSlotView] = []

var dice_slot_models: Array[DiceSlotData] = []
var owner_character: CharacterController


func _init() -> void:
	activate_dice_slot(0)
	activate_dice_slot(1)


func initialize(new_owner: CharacterController):
	set_owner_character(new_owner)
	initialize_models(new_owner)


func initialize_models(new_owner: CharacterController):
	for dice_slot in dice_slot_models:
		dice_slot.initialize(new_owner)


func roll_dice_slot(index: int):
	dice_slot_models[index].roll_speed_value()


func activate_dice_slot(index: int):
	dice_slot_models[index].activate()


#region Getter Setter
func set_owner_character(new_owner: CharacterController):
	owner_character = new_owner


func get_active_dice_slot() -> Array[DiceSlotData]:
	var active_dice_slots = []
	for dice_slot in dice_slot_models:
		if dice_slot.state == DiceSlotData.DiceSlotState.ACTIVE:
			active_dice_slots.append(dice_slot)
	
	return active_dice_slots


func get_random_dice_slot() -> DiceSlotData:
	var random_dice_slot = dice_slot_models.pick_random() as DiceSlotData
	return random_dice_slot
#endregion
