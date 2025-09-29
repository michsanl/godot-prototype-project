class_name StatsView
extends Control


@export var health_bar: TextureProgressBar
@export var stagger_bar: TextureProgressBar
@export var health_label: Label
@export var stagger_label: Label


func update_health(current_health: int, max_health: int):
	health_bar.value = current_health
	health_bar.max_value = max_health
	health_label.text = str(current_health)


func update_stagger(current_stagger: int, max_stagger: int):
	stagger_bar.value = current_stagger
	stagger_bar.max_value = max_stagger
	stagger_label.text = str(current_stagger)
