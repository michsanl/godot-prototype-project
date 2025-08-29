class_name CharacterController
extends Node2D

signal strategy_enter(target: CharacterController)
signal strategy_exit

@export var char_name: String

@export var stats: CharacterStats
@export var ability: CharacterAbility
@export var sprite: CharacterSprite
@export var movement: CharacterMovement
@export var dice_slot_pool: Array[CharacterDiceSlot]
@export var action_controller: CharacterActionController
@export var combat_controller: CharacterCombatController

@export var character_targeting: CharacterTargeting 
@export var character_action: CharacterAction

var win_response_helper: CharacterWinResponseHelper
var lose_response_helper: CharacterLoseResponseHelper
var draw_response_helper: CharacterDrawResponseHelper

@onready var initial_position: Vector2 = self.position


func _init() -> void:
	win_response_helper = CharacterWinResponseHelper.new(self)
	lose_response_helper = CharacterLoseResponseHelper.new(self)
	draw_response_helper = CharacterDrawResponseHelper.new(self)


func _ready() -> void:
	print(dice_slot_pool)
	for dice_slot in dice_slot_pool:
		dice_slot.set_owner_character(self)


func get_dice_slot_pool() -> Array[CharacterDiceSlot]:
	return dice_slot_pool


func apply_clash_win(clash_data: ClashData):
	await win_response_helper.resolve_win_response(clash_data)


func apply_clash_lose(clash_data: ClashData):
	await lose_response_helper.resolve_lose_response(clash_data)


func apply_clash_draw(clash_data: ClashData):
	await draw_response_helper.resolve_clash_draw(clash_data)


func reset_position():
	self.position = initial_position


func reset_visual():
	sprite.change_to_default_sprite()


func roll_all_dice_slot():
	for dice_slot in dice_slot_pool:
		dice_slot.roll_speed_value()



#region Character Action
func approach_target_one_sided(target: CharacterController):
	await character_action.perform_approach_one_sided_action(self, target)


func approach_target_two_sided(target: CharacterController):
	await character_action.perform_approach_two_sided_action(self, target)


func perform_slash_attack_win(target: CharacterController):
	await character_action.perform_slash_attack_win(self, target)


func perform_slash_attack_draw(attacker: CharacterController):
	await character_action.perform_slash_attack_draw(self, attacker)


func perform_damaged_action(attacker: CharacterController):
	await character_action.perform_damaged_action(self, attacker)
#endregion


#region Character Targeting
func set_target(new_target: CharacterController) -> void:
	character_targeting.set_target(new_target)


func set_aim_target(new_target: CharacterController) -> void:
	character_targeting.set_aim_target(new_target)


func remove_target() -> void:
	character_targeting.remove_target()


func remove_aim_target() -> void:
	character_targeting.remove_aim_target()
#endregion
