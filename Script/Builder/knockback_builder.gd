class_name KnockbackBuilder
extends RefCounted

var _distance: float
var _actor_pos: Vector2
var _target_pos: Vector2


func with_distance(new_distance: float) -> KnockbackBuilder:
	_distance = new_distance
	return self


func with_actor_pos(new_pos: Vector2) -> KnockbackBuilder:
	_actor_pos = new_pos
	return self


func with_target_pos(new_pos: Vector2) -> KnockbackBuilder:
	_target_pos = new_pos
	return self


func build() -> Vector2:
	var direction: Vector2 = (_target_pos - _actor_pos).normalized()
	var knockback_final_pos: Vector2 = (_distance * direction) + _target_pos
	return knockback_final_pos
