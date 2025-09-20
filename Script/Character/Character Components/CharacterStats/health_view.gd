class_name HealthView
extends Control

@export var health_bar: ProgressBar

func update_health(current: int, max: int):
	health_bar.max_value = max
	health_bar.value = current
