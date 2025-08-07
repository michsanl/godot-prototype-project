class_name CharacterAction
extends Node

@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual

func perform_move(this_character: CharacterBase, destination: Vector2):
	character_visual.change_to_move_sprite()
	await character_movement.move_position(this_character, destination)
	character_visual.change_to_default_sprite()


func perform_getting_hit():
	pass


func get_direction_to_target():
	pass
