class_name AbilityToken
extends Resource

enum TokenType { NOTSET, ATTACK, GUARD, EVADE }

@export var token_type: TokenType
@export var min: int = 0
@export var max: int = 0


func get_token_value() -> int:
	return randi_range(min, max)


func get_token_type() -> TokenType:
	return token_type
