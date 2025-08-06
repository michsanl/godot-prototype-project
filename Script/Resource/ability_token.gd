class_name AbilityToken
extends Resource

enum TokenType { NOTSET, ATTACK, GUARD, EVADE }

@export var min: int = 0
@export var max: int = 0

var token_type_test: TokenType


func get_token_value() -> int:
	return randi_range(min, max)
