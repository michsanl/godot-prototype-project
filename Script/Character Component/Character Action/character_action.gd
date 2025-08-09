class_name CharacterAction
extends Node

@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual
@export var attack_duration: float = 1.0
@export var damaged_duration: float = 1.0
@export var knock_offset: float = 100.0
@export var adjacent_offset: float = 50.0


#region Movement + Visual Methods
func perform_movement_action(actor: CharacterBase, final_pos: Vector2):
	character_visual.change_to_move_sprite()
	await character_movement.move_position(actor, final_pos)


func perform_approach_one_sided_action(actor: CharacterBase, target: CharacterBase):
	var final_pos: Vector2 = target.position + get_adjacent_offset(actor, target)
	character_visual.change_to_move_sprite()
	await character_movement.move_position(actor, final_pos)


func perform_approach_two_sided_action(actor: CharacterBase, target: CharacterBase):
	var final_pos: Vector2 = get_meeting_position(actor, target) + get_half_adjacent_offset(actor, target)
	character_visual.change_to_move_sprite()
	await character_movement.move_position(actor, final_pos)


func perform_slash_attack_win(actor: CharacterBase, target: CharacterBase):
	perform_slight_forward_movement(actor, target)
	character_visual.change_to_slash_sprite()
	await get_tree().create_timer(attack_duration).timeout


func perform_slash_attack_draw(actor: CharacterBase, target: CharacterBase):
	perform_knockback_movement(actor, target)
	character_visual.change_to_slash_sprite()
	await get_tree().create_timer(attack_duration).timeout


func perform_damaged_action(actor: CharacterBase, target: CharacterBase):
	perform_knockback_movement(actor, target)
	character_visual.change_to_damaged_sprite()
	await get_tree().create_timer(damaged_duration).timeout
#endregion


func perform_slight_forward_movement(actor: CharacterBase, target: CharacterBase):
	var final_pos: Vector2 = actor.position + get_direction_to_opponent(actor, target) * 25.0
	await character_movement.move_position_fast(actor, final_pos)


func perform_knockback_movement(actor: CharacterBase, target: CharacterBase):
	var final_pos: Vector2 = actor.position + get_knockback_offset(actor, target)
	await character_movement.move_position(actor, final_pos)


func reset_visual():
	character_visual.change_to_default_sprite()


#region Helper Methods
func get_meeting_position(actor: CharacterBase, target: CharacterBase) -> Vector2:
	return actor.position.lerp(target.position, 0.5)


func get_adjacent_offset(actor: CharacterBase, target: CharacterBase) -> Vector2:
	var final_offset: Vector2
	if actor.position.x > target.position.x:
		final_offset = Vector2(adjacent_offset * 1, 0)
		return Vector2(final_offset)
	else:
		final_offset = Vector2(adjacent_offset * -1, 0)
		return Vector2(final_offset)


func get_half_adjacent_offset(actor: CharacterBase, target: CharacterBase) -> Vector2:
	return get_adjacent_offset(actor, target)


func get_knockback_offset(actor: CharacterBase, target: CharacterBase) -> Vector2:
	return get_reversed_direction_to_opponent(actor, target) * knock_offset


func get_direction_to_opponent(actor: CharacterBase, target: CharacterBase) -> Vector2:
	return (target.position - actor.position).normalized()


func get_reversed_direction_to_opponent(actor: CharacterBase, target: CharacterBase) -> Vector2:
	return (target.position - actor.position).normalized() * -1
#endregion
