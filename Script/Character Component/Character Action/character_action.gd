class_name CharacterAction
extends Node

@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual
@export var attack_duration: float = 1.0
@export var damaged_duration: float = 1.0
@export var knock_offset: float = 50.0

func perform_move(this_character: CharacterBase, destination: Vector2):
	character_visual.change_to_move_sprite()
	await character_movement.move_position(this_character, destination)


func perform_approach_target_one_sided(this_character: CharacterBase, target: CharacterBase):
	character_visual.change_to_move_sprite()
	await character_movement.approach_target_one_sided(this_character, target)


func perform_approach_target_two_sided(this_character: CharacterBase, target: CharacterBase):
	character_visual.change_to_move_sprite()
	await character_movement.approach_target_two_sided(this_character, target)


func perform_slash_attack():
	character_visual.change_to_slash_sprite()
	await get_tree().create_timer(attack_duration).timeout


func perform_slash_attack_with_knockback(this_character: CharacterBase, opponent: CharacterBase):
	var knockback_destination: Vector2 = this_character.position + get_knockback_offset(this_character, opponent)
	
	character_visual.change_to_slash_sprite()
	character_movement.move_position(this_character, knockback_destination)
	await get_tree().create_timer(attack_duration).timeout


func perform_getting_damaged(this_character: CharacterBase, opponent: CharacterBase):
	var knockback_destination: Vector2 = this_character.position + get_knockback_offset(this_character, opponent)
	
	character_visual.change_to_damaged_sprite()
	await character_movement.move_position(this_character, knockback_destination)
	await get_tree().create_timer(damaged_duration).timeout


func reset_visual():
	character_visual.change_to_default_sprite()


#region Helper Methods
func get_knockback_offset(this_character: CharacterBase, opponent: CharacterBase) -> Vector2:
	return get_reversed_direction_to_opponent(this_character, opponent) * knock_offset


func get_direction_to_opponent(this_character: CharacterBase, opponent: CharacterBase) -> Vector2:
	return (opponent.position - this_character.position).normalized()


func get_reversed_direction_to_opponent(this_character: CharacterBase, opponent: CharacterBase) -> Vector2:
	return (opponent.position - this_character.position).normalized() * -1
#endregion
