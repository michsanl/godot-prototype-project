class_name DiceData
extends Resource

enum DiceType { ATTACK, GUARD, EVADE }

@export var dice_type: DiceType
@export var min: int = 0
@export var max: int = 0


func roll_dice() -> int:
	return randi_range(min, max)
