class_name VFXController
extends Sprite2D

@export var vfx_resource: VFXData

var self_owner:CharacterController


func set_vfx_controller_owner(new_owner: CharacterController):
	self_owner = new_owner


func clear_vfx():
	self.texture = null


func change_to_slash_vfx() -> void:
	set_sprite(vfx_resource.slash_vfx)


func change_to_pierce_vfx() -> void:
	set_sprite(vfx_resource.pierce_vfx)


func change_to_blunt_vfx() -> void:
	set_sprite(vfx_resource.blunt_vfx)


func change_to_guard_vfx() -> void:
	set_sprite(vfx_resource.block_vfx)


func set_sprite(target_sprite: Texture2D) -> void:
	self.texture = target_sprite
