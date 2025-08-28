@icon("res://Art/Ability_Icon.png")
class_name AbilityData
extends Resource

@export var ability_name: String
@export var dice_list: Array[DiceData]


func get_dice_pool() -> Array[DiceData]:
	return dice_list
