class_name HealthController
extends Node   # Use Node, not Control, unless you want this in the UI tree

signal on_died

@export var view: StatsView

var model: HealthModel
var owner_unit: CharacterController

func initialize(new_owner: CharacterController, max_health: int):
	owner_unit = new_owner
	model = HealthModel.new(max_health)

	# Connect model signals
	model.health_changed.connect(_on_health_changed)
	model.health_depleted.connect(_on_health_depleted)

	# Initialize view display
	if view:
		view.update_health(model.get_current_health(), model.get_max_health())

func damage(amount: int):
	model.decrease_health(amount)

func heal(amount: int):
	model.increase_health(amount)


func _on_health_changed(current_health: int, max_health: int):
	if view:
		view.update_health(current_health, max_health)

func _on_health_depleted():
	on_died.emit()
