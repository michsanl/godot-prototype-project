class_name CharacterDiceSlotController
extends Node

@export var dice_slot_pool: Array[CharacterDiceSlot] = []

var owner_character: CharacterController


func set_dice_slot_controller_owner(owner_chara: CharacterController):
	owner = owner_chara as CharacterController


func set_all_dice_slot_owner(new_owner: CharacterController):
	for dice_slot in dice_slot_pool:
		dice_slot.set_owner_character(new_owner)


func roll_all_dice_slots():
	for dice_slot in dice_slot_pool:
		dice_slot.roll_speed_value()


func get_dice_slot_pool() -> Array[CharacterDiceSlot]:
	return dice_slot_pool


func get_random_dice_slot() -> CharacterDiceSlot:
	var random_dice_slot = dice_slot_pool.pick_random() as CharacterDiceSlot
	return random_dice_slot
