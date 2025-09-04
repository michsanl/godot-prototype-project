class_name KnockbackData
extends RefCounted

var direction: Vector2
var distance: Vector2


func _init(new_direction:= Vector2.ZERO, new_distance:= Vector2.ZERO) -> void:
	direction = new_direction
	distance = new_distance	
