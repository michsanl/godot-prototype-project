extends Node
class_name Character_Stat

@export var health_point: int
@export var dice_point: int

func _ready() -> void:
	randomize_dice_point()
	randomize_health_point()
	
func randomize_dice_point():
	dice_point = randi_range(1, 10)
	
func randomize_health_point():
	health_point = randi_range(1, 10)
