@icon("res://Art/Ability_Icon.png")
class_name AbilityData
extends Resource

@export var ability_name: String
@export var dice_list: Array[DiceData]

var self_owner: CharacterController


func set_self_owner(new_owner: CharacterController):
	self_owner = new_owner
	_set_all_dice_owner(new_owner)


func get_dice_pool() -> Array[DiceData]:
	return dice_list


func _set_all_dice_owner(new_owner: CharacterController):
	for dice in dice_list:
		dice.set_self_owner(new_owner)
