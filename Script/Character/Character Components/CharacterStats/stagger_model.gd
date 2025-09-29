class_name StaggerModel
extends RefCounted

signal stagger_changed(current: int, max: int)
signal stagger_depleted

var _max_stagger: int
var _current_stagger: int


func _init(max_stagger: int = 100):
	_max_stagger = max_stagger
	_current_stagger = max_stagger


func increase_stagger(amount: float):
	_current_stagger = min(_max_stagger, _current_stagger + amount)
	stagger_changed.emit(_current_stagger, _max_stagger)


func decrease_stagger(amount: float):
	_current_stagger = max(0, _current_stagger - amount)
	stagger_changed.emit(_current_stagger, _max_stagger)
	if _current_stagger <= 0:
		stagger_depleted.emit()


func set_max_stagger(value: int, clamp_current: bool = true):
	_max_stagger = max(1, value)
	if clamp_current:
		_current_stagger = min(_current_stagger, _max_stagger)
	stagger_changed.emit(_current_stagger, _max_stagger)

#region Getter
func get_current_stagger() -> int:
	return _current_stagger

func get_max_stagger() -> int:
	return _max_stagger
#endregion
