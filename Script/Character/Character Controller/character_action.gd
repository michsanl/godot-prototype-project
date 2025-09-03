class_name CharacterAction
extends Node

@export var movement_helper: CharacterMovement
@export var sprite_controller: CharacterSprite
@export var attack_duration: float = 1.0
@export var damaged_duration: float = 1.0
@export var knock_offset: float = 100.0
@export var adjacent_offset: float = 100.0

var owner_character: CharacterController


#region Movement + Visual Methods
func perform_movement_action(actor: CharacterController, final_pos: Vector2):
	owner_character.sprite.change_to_move_sprite()
	await owner_character.movement.perform_forward_movement(actor, final_pos)


func perform_approach_one_sided_action(actor: CharacterController, target: CharacterController):
	var final_pos: Vector2 = target.position + _get_adjacent_offset(actor, target)
	owner_character.sprite.change_to_move_sprite()
	print("approaching one sided")
	await owner_character.movement.perform_forward_movement(actor, final_pos)


func perform_approach_two_sided_action(actor: CharacterController, target: CharacterController):
	var final_pos: Vector2 = _get_meeting_position(actor, target) + _get_fractional_adjacent_offset(actor, target, 0.5)
	owner_character.sprite.change_to_move_sprite()
	print("approaching two sided")
	await owner_character.movement.perform_forward_movement(actor, final_pos)


func perform_slash_attack_win(actor: CharacterController, target: CharacterController):
	perform_slight_forward_movement(actor, target)
	owner_character.sprite.change_to_slash_sprite()
	await get_tree().create_timer(attack_duration).timeout


func perform_slash_attack_draw(actor: CharacterController, target: CharacterController):
	perform_knockback_movement(actor, target)
	owner_character.sprite.change_to_slash_sprite()
	await get_tree().create_timer(attack_duration).timeout


func perform_damaged_action(actor: CharacterController, target: CharacterController):
	perform_knockback_movement(actor, target)
	owner_character.sprite.change_to_damaged_sprite()
	await get_tree().create_timer(damaged_duration).timeout
#endregion


func perform_slight_forward_movement(actor: CharacterController, target: CharacterController):
	var final_pos: Vector2 = actor.position + _get_direction_to_opponent(actor, target) * 25.0
	await owner_character.movement.move_position_fast(actor, final_pos)


func perform_knockback_movement(actor: CharacterController, target: CharacterController):
	var final_pos: Vector2 = actor.position + _get_knockback_offset(actor, target)
	await owner_character.movement.perform_forward_movement(actor, final_pos)


#region Helper Methods
func _get_meeting_position(actor: CharacterController, target: CharacterController) -> Vector2:
	return actor.position.lerp(target.position, 0.5)


func _get_adjacent_offset(actor: CharacterController, target: CharacterController) -> Vector2:
	var final_offset: Vector2
	if actor.position.x > target.position.x:
		final_offset = Vector2(adjacent_offset * 1, 0)
		return Vector2(final_offset)
	else:
		final_offset = Vector2(adjacent_offset * -1, 0)
		return Vector2(final_offset)


func _get_fractional_adjacent_offset(
	actor: CharacterController, 
	target: CharacterController, 
	factor: float
) -> Vector2:
	return factor * _get_adjacent_offset(actor, target)


func _get_knockback_offset(actor: CharacterController, target: CharacterController) -> Vector2:
	return _get_reversed_direction_to_opponent(actor, target) * knock_offset


func _get_direction_to_opponent(actor: CharacterController, target: CharacterController) -> Vector2:
	return (target.position - actor.position).normalized()


func _get_reversed_direction_to_opponent(actor: CharacterController, target: CharacterController) -> Vector2:
	return (target.position - actor.position).normalized() * -1
#endregion
