class_name CharacterActionController
extends Node

@export var sprite_controller: CharacterSprite
@export var vfx_controller: VFXController
@export var default_duration: float = 1.0
@export var attack_duration: float = 1.0
@export var damaged_duration: float = 1.0
@export var knock_offset: float = 100.0
@export var adjacent_offset: float = 100.0

var owner_character: CharacterController
var _knockback_distance: float = 150.0

func initialize(new_owner: CharacterController):
	owner_character = new_owner as CharacterController


#region Movement Methods
func perform_movement_action(final_pos: Vector2):
	owner_character.sprite.change_to_move_sprite()
	await owner_character.movement.perform_forward_movement(final_pos)
	owner_character.sprite.change_to_default_sprite()


func perform_approach_one_sided_action(target: CharacterController):
	var final_pos: Vector2 = target.position + _get_adjacent_offset(owner_character, target)
	owner_character.sprite.change_to_move_sprite()
	await owner_character.movement.perform_forward_movement(final_pos)
	owner_character.sprite.change_to_default_sprite()


func perform_approach_two_sided_action(actor: CharacterController, target: CharacterController):
	var final_pos: Vector2 = _get_meeting_position(actor, target) + _get_fractional_adjacent_offset(actor, target, 0.5)
	owner_character.sprite.change_to_move_sprite()
	await owner_character.movement.perform_forward_movement(final_pos)
	owner_character.sprite.change_to_default_sprite()
#endregion
	


#region Combat Action Method
func perform_default_action(duration: float = default_duration):
	sprite_controller.change_to_default_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_slash_action(opponent: CharacterController, is_draw: bool = false, duration: float = default_duration):
	sprite_controller.change_to_slash_sprite()
	vfx_controller.change_to_slash_vfx()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()
	vfx_controller.clear_vfx()


func perform_pierce_action(opponent: CharacterController, is_draw: bool = false, duration: float = default_duration):
	sprite_controller.change_to_pierce_sprite()
	vfx_controller.change_to_pierce_vfx()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()
	vfx_controller.clear_vfx()


func perform_blunt_action(opponent: CharacterController, is_draw: bool = false, duration: float = default_duration):
	sprite_controller.change_to_blunt_sprite()
	vfx_controller.change_to_blunt_vfx()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()
	vfx_controller.clear_vfx()


func perform_guard_action(duration: float = default_duration):
	sprite_controller.change_to_guard_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_evade_action(duration: float = default_duration):
	sprite_controller.change_to_evade_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_damaged_action(duration: float = default_duration):
	sprite_controller.change_to_damaged_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()
#endregion


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
#endregion
