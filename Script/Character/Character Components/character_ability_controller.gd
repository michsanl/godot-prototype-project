class_name CharacterAbilityController
extends Node

@export var ability_list: Array[AbilityData]


func set_ability_controller_owner(new_owner: CharacterController):
	owner = new_owner


func get_random_ability() -> AbilityData:
	return ability_list.pick_random()
