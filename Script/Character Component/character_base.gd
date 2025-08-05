class_name CharacterBase
extends Node2D

signal strategy_enter(target: CharacterBase)
signal strategy_exit

@export var character_targeting: CharacterTargeting 
@export var character_stat: Character_Stat 
@export var character_ability_manager: CharacterAbilityManager
@export var character_movement: CharacterMovement

@onready var initial_position: Vector2 = self.position

func handle_strategy_enter(new_target: CharacterBase):
	strategy_enter.emit(new_target)


func handle_strategy_exit():
	strategy_exit.emit()


func approach_target_one_sided(target: CharacterBase):
	await character_movement.approach_target_one_sided(self, target)


func approach_target_two_sided(target: CharacterBase):
	await character_movement.approach_target_two_sided(self, target)


func reset_position():
	self.position = initial_position


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
