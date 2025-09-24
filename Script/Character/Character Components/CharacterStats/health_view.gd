class_name HealthView
extends Control

@export var health_bar: ProgressBar

func update_health(current_health: int, max_health: int):
	health_bar.max_value = max_health
	health_bar.value = current_health
