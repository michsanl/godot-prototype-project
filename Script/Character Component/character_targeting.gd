extends Node
class_name Character_Targeting

var target: Character_Base = null

func set_target(new_target: Character_Base) -> void:
	target = new_target
	print (owner, " Target is: ", new_target.name)
