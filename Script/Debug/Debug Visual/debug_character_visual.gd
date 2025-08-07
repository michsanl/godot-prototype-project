extends Node2D

@export var character: CharacterBase


func _on_default_pressed() -> void:
	character.character_visual.change_to_default_sprite()


func _on_slash_pressed() -> void:
	character.character_visual.change_to_slash_sprite()


func _on_pierce_pressed() -> void:
	character.character_visual.change_to_pierce_sprite()


func _on_blunt_pressed() -> void:
	character.character_visual.change_to_blunt_sprite()


func _on_move_pressed() -> void:
	character.character_visual.change_to_move_sprite()


func _on_guard_pressed() -> void:
	character.character_visual.change_to_block_sprite()


func _on_damaged_pressed() -> void:
	character.character_visual.change_to_damaged_sprite()
