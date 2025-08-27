class_name CharacterDiceSlotController
extends Node

@export var dice_slot_pool: Array[CharacterDiceSlot] = []


func set_owner_all_dice_slot(owner: CharacterBase):
	for dice_slot in dice_slot_pool:
		dice_slot.set_owner_character(owner)


func roll_all_dice_slot():
	for dice_slot in dice_slot_pool:
		dice_slot.roll()


func get_dice_slot_pool() -> Array[CharacterDiceSlot]:
	return dice_slot_pool
