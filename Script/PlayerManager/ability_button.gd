class_name AbilityButton
extends Control

@export var view: AbilityView
@export var button: Button
@export var icon: Sprite2D

var index: int
var default_icon: Texture2D


func initialize(new_index: int):
	index = new_index


func update_icon(new_icon: Texture2D):
	#icon.texture = new_icon
	pass


func _on_button_pressed() -> void:
	view._on_button_pressed(index)
