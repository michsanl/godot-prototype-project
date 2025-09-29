class_name StatsController
extends Node

@export var stats_data: StatsData
@export var health: HealthController
@export var stagger: StaggerController
@export var view: StatsView

var owner_unit: CharacterController
var temporary_resistance: float = 0.5

func initialize(new_owner: CharacterController):
	owner_unit = new_owner
	
	health.health_changed.connect(_on_health_changed)
	health.health_depleted.connect(_on_health_depleted)
	stagger.stagger_changed.connect(_on_stagger_changed)
	stagger.stagger_broken.connect(_on_stagger_broken)
	
	health.initialize(new_owner, stats_data._max_health)
	stagger.initialize(new_owner, stats_data._max_stagger)


func apply_damage(amount: int):
	process_health_damage(amount)
	process_stagger_damage(amount)


# TODO: Health take reduced damage
func process_health_damage(amount: int):
	var final_amount = amount * 2
	health.damage(final_amount)


func process_stagger_damage(amount: int):
	var final_amount = amount * 4
	stagger.decrease(final_amount)


func _on_health_changed(current_health: int, max_health: int):
	view.update_health(current_health, max_health)


func _on_stagger_changed(current_stagger: int, max_stagger: int):
	view.update_stagger(current_stagger, max_stagger)


func _on_health_depleted():
	Debug.log("Dead")


func _on_stagger_broken():
	Debug.log("Stagger broken")
