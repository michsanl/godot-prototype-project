class_name IDice
extends Resource

enum DiceType { SLASH, PIERCE, BLUNT, GUARD, EVADE }

@export var min_val: int = 0
@export var max_val: int = 0
@export var knockback_power: float = 50.0
@export var duration: float = 0.5
@export var vfx: AtlasTexture

var roll_val: int = 0
var dice_type: DiceType
var owner: CharacterController

func initialize(new_owner: CharacterController):
	owner = new_owner

func execute(owner: CharacterController, opponent: CharacterController):
	assert(false, "execute() not implemented")

func execute_draw(owner: CharacterController, opponent: CharacterController):
	assert(false, "execute() not implemented")

func get_roll_value() -> int:
	roll_val = randi_range(min_val, max_val)
	return roll_val

func get_knockback(actor: CharacterController, target: CharacterController, distance: float):
	return KnockbackBuilder.new() \
		.with_distance(distance) \
		.with_actor_pos(actor.global_position) \
		.with_target_pos(target.global_position) \
		.build()
