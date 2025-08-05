class_name CharacterBase
extends Node2D


@export var character_targeting: CharacterTargeting 
@export var character_stat: Character_Stat 
@export var character_ability_manager: CharacterAbilityManager
@export var character_movement: CharacterMovement

signal strategy_enter(target: CharacterBase)
signal strategy_exit


func handle_strategy_enter(new_target: CharacterBase):
	strategy_enter.emit(new_target)


func handle_strategy_exit():
	strategy_exit.emit()


func move_position(target: CharacterBase, duration: float):
	await character_movement.move_position(self, target.position, duration)
	print("move complete")


func randomize_dice_point() -> void:
	character_stat.randomize_dice_point()


func set_target(new_target: CharacterBase) -> void:
	character_targeting.set_target(new_target)


func set_aim_target(new_target: CharacterBase) -> void:
	character_targeting.set_aim_target(new_target)


func remove_target() -> void:
	character_targeting.remove_target()


func remove_aim_target() -> void:
	character_targeting.remove_aim_target()
