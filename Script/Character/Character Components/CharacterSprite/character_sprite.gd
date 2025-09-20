class_name CharacterSprite
extends Sprite2D

@export var sprite_resource: CharacterSpriteResource

var self_owner: CharacterController

func _ready() -> void:
	change_to_default_sprite()


func initialize(new_owner: CharacterController):
	self_owner = new_owner


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


func change_to_guard_sprite() -> void:
	set_sprite(sprite_resource.block_sprite)


func change_to_damaged_sprite() -> void:
	set_sprite(sprite_resource.damaged_sprite)


func change_to_evade_sprite() -> void:
	set_sprite(sprite_resource.block_sprite)


func set_sprite(target_sprite: Texture2D) -> void:
	self.texture = target_sprite
