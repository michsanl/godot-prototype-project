class_name CharacterVisual
extends Node

enum VisualType { DEFAULT, SLASH, PIERCE, BLUNT, MOVE, BLOCK, DAMAGED }

@export var sprite_node: Sprite2D
@export var sprite_resource: CharacterSpriteResource
@export var debug_visual: VisualType:
	set(value):
		_debug_visual = value
		_on_debug_visual_changed(value)

var _debug_visual: VisualType


func change_to_default_sprite() -> void:
	set_sprite(sprite_resource.default_sprite)


func change_to_slash_sprite() -> void:
	set_sprite(sprite_resource.slash_sprite)


func change_to_pierce_sprite() -> void:
	set_sprite(sprite_resource.pierce_sprite)


func change_to_blunt_sprite() -> void:
	set_sprite(sprite_resource.blunt_sprite)


func change_to_move_sprite() -> void:
	set_sprite(sprite_resource.move_sprite)


func change_to_block_sprite() -> void:
	set_sprite(sprite_resource.block_sprite)


func change_to_damaged_sprite() -> void:
	set_sprite(sprite_resource.damaged_sprite)


func set_sprite(target_sprite: Texture2D) -> void:
	sprite_node.texture = target_sprite


func _on_debug_visual_changed(visual_type: VisualType):
	match visual_type:
		VisualType.DEFAULT:
			change_to_default_sprite()
		VisualType.SLASH:
			change_to_slash_sprite()
		VisualType.PIERCE:
			change_to_pierce_sprite()
		VisualType.BLUNT:
			change_to_blunt_sprite()
		VisualType.MOVE:
			change_to_move_sprite()
		VisualType.BLOCK:
			change_to_block_sprite()
		VisualType.DAMAGED:
			change_to_damaged_sprite()
