class_name CharacterBase
extends Node2D

signal strategy_enter(target: CharacterBase)
signal strategy_exit

@export var char_name: String
@export var character_targeting: CharacterTargeting 
@export var character_stat: Character_Stat 
@export var ability_manager: CharacterAbility
@export var character_action: CharacterAction
@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual

@export var dice_slot_controller: CharacterDiceSlotController

var win_response_helper: CharacterWinResponseHelper
var lose_response_helper: CharacterLoseResponseHelper
var draw_response_helper: CharacterDrawResponseHelper

@onready var initial_position: Vector2 = self.position


func _init() -> void:
	win_response_helper = CharacterWinResponseHelper.new()


func apply_clash_win(clash_data: ClashData):
	pass


func apply_clash_lose(clash_data: ClashData):
	pass


func apply_clash_draw(clash_data: ClashData):
	pass


func reset_position():
	self.position = initial_position


func reset_visual():
	character_action.reset_visual()


#region Character Action
func approach_target_one_sided(target: CharacterBase):
	await character_action.perform_approach_one_sided_action(self, target)


func approach_target_two_sided(target: CharacterBase):
	await character_action.perform_approach_two_sided_action(self, target)


func perform_slash_attack_win(target: CharacterBase):
	await character_action.perform_slash_attack_win(self, target)


func perform_slash_attack_draw(attacker: CharacterBase):
	await character_action.perform_slash_attack_draw(self, attacker)


func perform_damaged_action(attacker: CharacterBase):
	await character_action.perform_damaged_action(self, attacker)
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
