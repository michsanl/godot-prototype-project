class_name CharacterMovement
extends Node


func move_position(character: CharacterBase, target_position: Vector2, duration: float):
	var tween: Tween = create_tween()
	tween.tween_property(character, "position", target_position, duration).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
