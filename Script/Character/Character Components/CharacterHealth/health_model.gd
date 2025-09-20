class_name HealthModel
extends RefCounted

signal health_changed(current_health: int, max_health: int)
signal died

var _max_health: int
var _current_health: int
var _owner: CharacterController

func _init(new_owner: CharacterController = null, max_health: int = 100):
	_max_health = max_health
	_current_health = max_health
	_owner = new_owner

#region Getter
func get_health() -> int:
	return _current_health
func get_max_health() -> int:
	return _max_health
func get_owner() -> CharacterController:
	return _owner
#endregion

func increase_health(amount: int):
	_current_health = max(0, _current_health - amount)
	health_changed.emit(_current_health, _max_health)
	if _current_health == 0:
		died.emit()

func decrease_health(amount: int):
	_current_health = min(_max_health, _current_health - amount)
	health_changed.emit(_current_health, _max_health)
