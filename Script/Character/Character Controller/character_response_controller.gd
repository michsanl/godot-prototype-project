class_name CharacterResponseController
extends Node

@export var character_visual: CharacterVisual
@export var default_duration: float = 1.0


func perform_slash_action(duration: float = default_duration):
	character_visual.change_to_slash_sprite()
	await get_tree().create_timer(duration).timeout
	character_visual.change_to_default_sprite()


func perform_pierce_action(duration: float = default_duration):
	character_visual.change_to_pierce_sprite()
	await get_tree().create_timer(duration).timeout
	character_visual.change_to_default_sprite()


func perform_blunt_action(duration: float = default_duration):
	character_visual.change_to_blunt_sprite()
	await get_tree().create_timer(duration).timeout
	character_visual.change_to_default_sprite()


func perform_guard_action(duration: float = default_duration):
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(duration).timeout
	character_visual.change_to_default_sprite()


func perform_evade_action(duration: float = default_duration):
	character_visual.change_to_evade_sprite()
	await get_tree().create_timer(duration).timeout
	character_visual.change_to_default_sprite()


func perform_damaged_action(duration: float = default_duration):
	character_visual.change_to_damaged_sprite()
	await get_tree().create_timer(duration).timeout
	character_visual.change_to_default_sprite()
