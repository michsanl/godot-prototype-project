class_name CharacterBase
extends Node2D

signal strategy_enter(target: CharacterBase)
signal strategy_exit

@export var character_targeting: CharacterTargeting 
@export var character_stat: Character_Stat 
@export var character_ability_manager: CharacterAbilityManager
@export var character_action: CharacterAction
@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual

@onready var initial_position: Vector2 = self.position


#region Character Action
func approach_target_one_sided(target: CharacterBase):
	await character_action.perform_approach_target_one_sided(self, target)


func approach_target_two_sided(target: CharacterBase):
	await character_action.perform_approach_target_two_sided(self, target)


func perform_slash_attack():
	await character_action.perform_slash_attack()


func perform_slash_attack_with_knockback(attacker: CharacterBase):
	await character_action.perform_slash_attack_with_knockback(self, attacker)


func perform_damaged_action(attacker: CharacterBase):
	await character_action.perform_getting_damaged(self, attacker)


func reset_position():
	self.position = initial_position
	character_action.reset_visual()
#endregion


#region Character Targeting
func set_target(new_target: CharacterBase) -> void:
	character_targeting.set_target(new_target)


func set_aim_target(new_target: CharacterBase) -> void:
	character_targeting.set_aim_target(new_target)


func remove_target() -> void:
	character_targeting.remove_target()


func remove_aim_target() -> void:
	character_targeting.remove_aim_target()
#endregion


func randomize_dice_point() -> void:
	character_stat.randomize_dice_point()
