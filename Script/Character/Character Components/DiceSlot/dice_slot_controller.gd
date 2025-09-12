class_name DiceSlotController
extends Control

@export var views: Array[DiceSlotView] = []

var dice_slots: Array[DiceSlotData] = []
var owner_character: CharacterController
var min_speed_value: int
var max_speed_value: int


func initialize(new_owner, min_value = 1, max_value = 10):
	owner_character = new_owner
	max_speed_value = max_value
	min_speed_value = min_value
	
	_initialize_models()
	_initialize_views()
	
	activate_dice_slot(0)
	activate_dice_slot(1)


func roll_dice_slot(index: int):
	dice_slots[index].roll_speed_value()


func activate_dice_slot(index: int):
	dice_slots[index].activate()


func deactivate_dice_slot(index: int):
	dice_slots[index].deactivate()


func set_dice_slot_target(index: int, target: DiceSlotData):
	dice_slots[index].set_target_slot(target)


func set_dice_slot_ability(index: int, ability: AbilityData):
	dice_slots[index].set_selected_ability(ability)


func _initialize_models():
	dice_slots.resize(len(views))
	
	for i in range(len(dice_slots)):
		dice_slots[i] = DiceSlotData.new()
		dice_slots[i].initialize(owner_character, min_speed_value, max_speed_value)
	
	print(dice_slots)


func _initialize_views():
	for i in range(len(dice_slots)):
		views[i].initialize(dice_slots[i])
