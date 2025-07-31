extends Node
class_name Ability_Resource

@export var token: Array[Ability_Token] = []

@export var ability_name: String
@export var description: String

@export var cooldown: int = 0
@export var base_damage: int = 0
@export var status_effects: Array[Resource] = []
