class_name HealthController
extends Node 

signal health_changed(current: int, max: int)
signal health_depleted

var model: HealthModel
var owner_unit: CharacterController

func initialize(new_owner: CharacterController, max_health: int):
	owner_unit = new_owner
	model = HealthModel.new(max_health)

	model.health_changed.connect(_on_health_changed)
	model.health_depleted.connect(_on_health_depleted)
	
	health_changed.emit(model.get_current_health(), model.get_max_health())


func damage(amount: float):
	model.decrease_health(amount)


func heal(amount: float):
	model.increase_health(amount)


func _on_health_changed(current_health: int, max_health: int):
	health_changed.emit(current_health, max_health)


func _on_health_depleted():
	health_depleted.emit()
