class_name CharacterMovement
extends Node

@export var move_duration_fast: float = 0.1
@export var move_duration_standard: float = 0.25
@export var move_duration_slow: float = 0.4
@export var backward_move_duration: float = 0.2

var owner_character: CharacterController

func initialize(new_owner: CharacterController):
	owner_character = new_owner as CharacterController


func perform_forward_movement(final_pos: Vector2):
	var tween: Tween = owner_character.create_tween()
	tween.tween_property(
		owner_character, 
		"position", 
		final_pos, 
		move_duration_standard
	).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func perform_backward_movement(final_pos: Vector2):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(
		owner_character, 
		"position", 
		final_pos, 
		backward_move_duration
	).set_ease(Tween.EASE_OUT)
