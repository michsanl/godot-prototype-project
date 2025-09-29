class_name HealthModel
extends RefCounted

signal health_changed(current: int, max: int)
signal health_depleted

var _max_health: int
var _current_health: int

func _init(max_health: int = 100):
	_max_health = max_health
	_current_health = max_health

func increase_health(amount: int):
	_current_health = min(_max_health, _current_health + amount)
	health_changed.emit(_current_health, _max_health)

func decrease_health(amount: int):
	_current_health = max(0, _current_health - amount)
	health_changed.emit(_current_health, _max_health)
	if _current_health <= 0:
		health_depleted.emit()

func set_max_health(value: int, clamp_current: bool = true):
	_max_health = max(1, value)
	if clamp_current:
		_current_health = min(_current_health, _max_health)
	health_changed.emit(_current_health, _max_health)

#region Getter
func get_current_health() -> int:
	return _current_health

func get_max_health() -> int:
	return _max_health
#endregion
