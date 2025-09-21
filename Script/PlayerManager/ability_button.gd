class_name AbilityButton
extends Control

signal button_pressed(index: int)

@export var button: Button
@export var icon: Sprite2D

var index: int
var default_icon: Texture2D


func initialize(new_index: int):
	index = new_index
	default_icon = icon.texture


func _on_button_pressed() -> void:
	button_pressed.emit(index)	


func update_icon(new_icon: Texture2D):
	icon.texture = new_icon
