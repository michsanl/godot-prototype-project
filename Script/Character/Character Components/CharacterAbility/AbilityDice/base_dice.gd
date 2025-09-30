class_name BaseDice
extends Resource

enum DiceType { SLASH, PIERCE, BLUNT, GUARD, EVADE }

@export var min_val: int = 0
@export var max_val: int = 0
@export var knockback_power: float = 5000
@export var duration: float = 0.5
@export var vfx: AtlasTexture
@export var type_icon: Texture2D

var roll_val: int = 0
var dice_type: DiceType
var owner_unit: CharacterController

func initialize(new_owner: CharacterController):
	owner_unit = new_owner

@warning_ignore("unused_parameter")
func execute(new_owner: CharacterController, opponent: CharacterController):
	assert(false, "execute() not implemented")

@warning_ignore("unused_parameter")
func execute_draw(new_owner: CharacterController, opponent: CharacterController):
	assert(false, "execute() not implemented")


func get_roll_value() -> int:
	roll_val = randi_range(min_val, max_val)
	return roll_val


func get_min_val() -> int:
	return min_val


func get_max_val() -> int:
	return max_val


func get_icon() -> Texture2D:
	return type_icon


func get_knockback(actor: CharacterController, target: CharacterController, distance: float):
	return KnockbackBuilder.new() \
		.with_distance(distance) \
		.with_actor_pos(actor.global_position) \
		.with_target_pos(target.global_position) \
		.build()


func _get_direction(opponent: CharacterController) -> Vector2:
	var dir = opponent.position - self.owner_unit.position
	return dir
