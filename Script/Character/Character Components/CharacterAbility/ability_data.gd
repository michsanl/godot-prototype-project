class_name AbilityData
extends Resource

@export var dices: Array[BaseDice]
@export var ability_name: String
@export var icon: Texture2D

var self_owner: CharacterController

func initialize(new_owner: CharacterController):
	self_owner = new_owner
	_initialize_childs(new_owner)

func _initialize_childs(new_owner: CharacterController):
	for dice in dices:
		dice.initialize(new_owner)

func get_dice_pool() -> Array[BaseDice]:
	return dices

func get_icon() -> Texture2D:
	return icon
