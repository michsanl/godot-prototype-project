class_name CombatDiceIcon
extends Control

@export var icon: TextureRect
@export var range_label: Label
@export var roll_label: Label

func _ready() -> void:
	show_roll_label(false)


func update_icon(new_texture: Texture2D):
	icon.texture = new_texture


func update_range_label(new_text: String):
	range_label.text = new_text


func update_roll_label(new_text: String):
	roll_label.text = new_text


func show_label(condition: bool):
	if condition:
		range_label.show()
	else:
		range_label.hide()


func show_icon(condition: bool):
	if condition:
		icon.show()
	else:
		icon.hide()


func show_roll_label(condition: bool):
	if condition:
		roll_label.show()
	else:
		roll_label.hide()
