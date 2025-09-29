class_name HealthController
extends Stats 

var model: HealthModel
var owner_unit: CharacterController


func initialize(new_owner: CharacterController, max_health: int):
	owner_unit = new_owner
	model = HealthModel.new(max_health)

	model.health_changed.connect(_on_health_changed)
	model.health_depleted.connect(_on_health_depleted)
	
	value_changed.emit(model.get_current_health(), model.get_max_health())


func decrease(amount: float):
	model.decrease_health(amount)


func increase(amount: float):
	model.increase_health(amount)


func _on_health_changed(current_health: int, max_health: int):
	value_changed.emit(current_health, max_health)


func _on_health_depleted():
	depleted.emit()
