extends Node
class_name Ability_Token

enum TokenType { NULL, ATTACK, DEFENSE, EVADE }

@export var token_type: TokenType = TokenType.NULL
@export var min: int = 0
@export var max: int = 0
