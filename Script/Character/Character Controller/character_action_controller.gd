class_name CharacterActionController
extends Node

@export var sprite_controller: CharacterSprite
@export var default_duration: float = 1.0


func perform_default_action(duration: float = default_duration):
	sprite_controller.change_to_default_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_slash_action(duration: float = default_duration):
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_pierce_action(duration: float = default_duration):
	sprite_controller.change_to_pierce_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_blunt_action(duration: float = default_duration):
	sprite_controller.change_to_blunt_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_guard_action(duration: float = default_duration):
	sprite_controller.change_to_guard_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_evade_action(duration: float = default_duration):
	sprite_controller.change_to_evade_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()


func perform_damaged_action(duration: float = default_duration):
	sprite_controller.change_to_damaged_sprite()
	await get_tree().create_timer(duration).timeout
	sprite_controller.change_to_default_sprite()
