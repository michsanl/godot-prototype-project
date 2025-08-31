class_name CharacterMovement
extends Node

@export var move_duration_fast: float = 0.1
@export var move_duration_standard: float = 0.25
@export var move_duration_slow: float = 0.4

var owner_character: CharacterController

func move_position(actor: CharacterController, final_pos: Vector2):
	var tween: Tween = create_tween()
	tween.tween_property(
		actor, 
		"position", 
		final_pos, 
		move_duration_standard
	).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func move_position_fast(actor: CharacterController, final_pos: Vector2):
	var tween: Tween = create_tween()
	tween.tween_property(
		actor, 
		"position", 
		final_pos, 
		move_duration_fast
	).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func move_position_slow(actor: CharacterController, final_pos: Vector2):
	var tween: Tween = create_tween()
	tween.tween_property(
		actor, 
		"position", 
		final_pos, 
		move_duration_slow
	).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
