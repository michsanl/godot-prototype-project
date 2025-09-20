class_name CharacterAbilityController
extends Node

@export var ability_list: Array[AbilityData]

var owner_character: CharacterController

func initialize(new_owner: CharacterController):
	owner_character = new_owner
	initialize_abiliities(new_owner)


func get_random_ability() -> AbilityData:
	return ability_list.pick_random()


func initialize_abiliities(new_owner: CharacterController):
	for ability in ability_list:
		ability.initialize(new_owner)
