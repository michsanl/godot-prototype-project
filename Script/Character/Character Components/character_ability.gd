class_name CharacterAbility
extends Node

@export var ability_list: Array[AbilityData]

var owner_character: CharacterController

func get_random_ability() -> AbilityData:
	return ability_list.pick_random()
