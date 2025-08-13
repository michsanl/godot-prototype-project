extends Node
class_name Character_Stat

@export var health_point: int = 10
@export var dice_point: int

var current_health: int


func get_dice_value() -> int:
	return dice_point


func randomize_dice_point():
	dice_point = randi_range(1, 10)
	#print(get_parent().name, " dice points are: ", dice_point)


func setup_health_point():
	current_health = health_point
