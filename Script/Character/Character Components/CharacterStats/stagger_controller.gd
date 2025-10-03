class_name StaggerController
extends Stats

var model: StaggerModel
var owner_unit: CharacterController


func initialize(new_owner: CharacterController, max_stagger: int):
	owner_unit = new_owner
	model = StaggerModel.new(max_stagger)

	model.stagger_changed.connect(_on_stagger_changed)
	model.stagger_depleted.connect(_on_stagger_depleted)

	value_changed.emit(model.get_current_stagger(), model.get_max_stagger())


func increase(amount: float):
	model.increase_stagger(amount)


func decrease(amount: float):
	model.decrease_stagger(amount)


func _on_stagger_changed(current_stagger: int, max_stagger: int):
	value_changed.emit(current_stagger, max_stagger)


func _on_stagger_depleted():
	depleted.emit()
