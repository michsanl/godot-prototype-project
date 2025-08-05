class_name CharacterMovement
extends Node

@export var move_duration: float = 0.25
@export var offset: float = 55.0

func approach_target_one_sided(character: CharacterBase, target: CharacterBase):
	var final_position: Vector2 = get_target_adjacent_position(character, target)
	var tween: Tween = create_tween()
	tween.tween_property(character, "position", final_position, move_duration).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	await get_tree().create_timer(1.0).timeout

func approach_target_two_sided(character: CharacterBase, target: CharacterBase):
	var final_position: Vector2 = get_meeting_poition(character, target) + get_half_offset(character, target)
	var tween: Tween = create_tween()
	tween.tween_property(character, "position", final_position, move_duration).set_ease(Tween.EASE_IN)
	await tween.finished
	await get_tree().create_timer(1.0).timeout


func get_meeting_poition(character: CharacterBase, target: CharacterBase) -> Vector2:
	return character.position.lerp(target.position, 0.5)


func get_target_adjacent_position(character: CharacterBase, target: CharacterBase) -> Vector2:
	return target.position + get_offset(character, target)


func get_offset(character: CharacterBase, target: CharacterBase) -> Vector2:
	if (character.position.x > target.position.x):
		return Vector2(offset, 0.0)
	else:
		return Vector2((offset * -1), 0.0)


func get_half_offset(character: CharacterBase, target: CharacterBase) -> Vector2:
	return get_offset(character,target) * 0.5
