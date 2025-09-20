class_name DiceDataa
extends IDice

#enum DiceType { ATTACK, GUARD, EVADE }
enum OffensiveType { SLASH, PIERCE, BLUNT }

#@export var dice_type: DiceType
@export var offensive_type: OffensiveType
#@export var min_val: int = 0
#@export var max_val: int = 0
#@export var knockback_power: float = 150.0

var self_owner: CharacterController

func initialize(new_owner: CharacterController):
	self_owner = new_owner


func roll_dice() -> int:
	return randi_range(min_val, max_val)
