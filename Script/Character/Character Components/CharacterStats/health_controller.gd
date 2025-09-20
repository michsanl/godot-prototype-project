class_name HealthController
extends Control

signal on_died

@export var view: HealthView

var model: HealthModel

func initialize(new_owner: CharacterController, max_health: int):
	owner = new_owner
	model = HealthModel.new(new_owner, max_health)
	
	model.health_changed.connect(view.update_health)
	model.died.connect(_on_died)

func damage(amount: int):
	model.decrease_health(amount)

func heal(amount: int):
	model.increase_health(amount)

func _on_died():
	on_died.emit()
