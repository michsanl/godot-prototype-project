extends Node
class_name Character_Ability

@export var ability_stats: Array[AbilityStats]

var abilities: Array[Ability] = []

func _ready() -> void:
	setup_ability()
	print(get_parent().name, " abilities are: " ,abilities)


func setup_ability():
	for stats in ability_stats:
		var ability = create_ability_class()
		ability.ability_stats = stats
		abilities.append(ability)


func create_ability_class():
	return preload("res://Script/Character Component/Character Ability/ability.gd").new()
