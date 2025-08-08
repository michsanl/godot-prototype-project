class_name CharacterAction
extends Node

@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual
@export var attack_duration: float = 1.0

func perform_move(this_character: CharacterBase, destination: Vector2):
	character_visual.change_to_move_sprite()
	await character_movement.move_position(this_character, destination)


func perform_approach_target_one_sided(this_character: CharacterBase, target: CharacterBase):
	character_visual.change_to_move_sprite()
	await character_movement.approach_target_one_sided(this_character, target)
	#character_visual.change_to_default_sprite()
	#await get_tree().create_timer(0.25).timeout


func perform_approach_target_two_sided(this_character: CharacterBase, target: CharacterBase):
	character_visual.change_to_move_sprite()
	await character_movement.approach_target_two_sided(this_character, target)
	#character_visual.change_to_default_sprite()
	#await get_tree().create_timer(0.25).timeout


func perform_slash_attack():
	character_visual.change_to_slash_sprite()
	await get_tree().create_timer(attack_duration).timeout


func reset_visual():
	character_visual.change_to_default_sprite()
	


func perform_getting_hit():
	pass


func get_direction_to_target():
	pass
