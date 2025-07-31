extends Node
class_name Character_Ability

var abilities: Array[Ability]

func _ready() -> void:
	GatherAbilities()
		
func GatherAbilities():
	for child in get_children():
		if child is Ability:
			abilities.append(child)
	print(owner, " ability : ", abilities)
