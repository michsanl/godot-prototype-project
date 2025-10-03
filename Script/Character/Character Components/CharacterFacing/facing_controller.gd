class_name FacingController
extends Node

@export var is_player: bool

@onready var sprite = $"../Sprite"
@onready var vfx = $"../VFX"

var owner_unit: CharacterController

func initialize(new_owner: CharacterController):
	owner_unit = new_owner
	reset_facing()


func update_facing(direction: Vector2):
	if direction.x > 0:
		face_right()
	else:
		face_left()


func resolve_and_update_facing(target: CharacterController):
	var facing_direction: = (target.position - owner_unit.position).normalized()
	update_facing(facing_direction)


func reset_facing():
	if is_player:
		face_right()
	else:
		face_left()
	


func face_right():
	sprite.flip_h = true
	vfx.flip_h = true


func face_left():
	sprite.flip_h = false
	vfx.flip_h = false
