class_name StatsController
extends Node

@export var stats_data: StatsData
@export var health: HealthController
@export var view: StatsView

var owner_unit: CharacterController
var temporary_resistance: float = 0.5

func initialize(new_owner: CharacterController):
	owner_unit = new_owner
	health.initialize(new_owner, stats_data._max_health)
	
	health.health_changed.connect(_on_health_changed)
	health.on_died.connect(_on_died)
	

func apply_damage(amount: int):
	process_health_damage(amount)


# TODO: Health take reduced damage
func process_health_damage(amount: int):
	var final_amount =  amount
	health.damage(final_amount)


func _on_health_changed(current_health: int, max_health: int):
	view.update_health(current_health, max_health)


func _on_died():
	Debug.log("Dead")
