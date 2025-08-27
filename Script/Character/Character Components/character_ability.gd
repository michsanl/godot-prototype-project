class_name CharacterAbility
extends Node

@export var ability_list: Array[AbilityData]


func get_random_ability() -> AbilityData:
	return ability_list.pick_random()
