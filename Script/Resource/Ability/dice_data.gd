class_name DiceData
extends Resource

enum DiceType { ATTACK, GUARD, EVADE }

@export var dice_type: DiceType
@export var min_val: int = 0
@export var max_val: int = 0


func roll_dice() -> int:
	return randi_range(min_val, max_val)
