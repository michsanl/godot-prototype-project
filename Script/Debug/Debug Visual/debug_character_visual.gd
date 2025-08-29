extends Node2D

@export var character: CharacterController


func _on_default_pressed() -> void:
	character.sprite_controller.change_to_default_sprite()


func _on_slash_pressed() -> void:
	character.sprite_controller.change_to_slash_sprite()


func _on_pierce_pressed() -> void:
	character.sprite_controller.change_to_pierce_sprite()


func _on_blunt_pressed() -> void:
	character.sprite_controller.change_to_blunt_sprite()


func _on_move_pressed() -> void:
	character.sprite_controller.change_to_move_sprite()


func _on_guard_pressed() -> void:
	character.sprite_controller.change_to_guard_sprite()


func _on_damaged_pressed() -> void:
	character.sprite_controller.change_to_damaged_sprite()
