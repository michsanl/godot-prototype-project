class_name CharacterController
extends Node2D

@export var char_name: String

@export var stats: CharacterStats
@export var sprite: CharacterSprite
@export var movement: CharacterMovement
@export var ability_controller: CharacterAbilityController
@export var dice_slot_controller: CharacterDiceSlotController
@export var action_controller: CharacterActionController
@export var combat_controller: CharacterCombatController

var one_sided_response_helper = CharacterOneSidedResponseHelper.new(self)
var win_response_helper: = CharacterWinResponseHelper.new(self)
var lose_response_helper: = CharacterLoseResponseHelper.new(self)
var draw_response_helper: = CharacterDrawResponseHelper.new(self)

var _initial_position: Vector2


func _ready() -> void:
	_set_childs_owner()
	_initial_position = self.position


func _set_childs_owner():
	sprite.set_sprite_owner(self)
	movement.set_movement_owner(self)
	ability_controller.set_ability_controller_owner(self)
	action_controller.set_action_controller_owner(self)
	dice_slot_controller.set_dice_slot_controller_owner(self)
	dice_slot_controller.set_all_dice_slot_owner(self)


#region Action Controller
func approach_target_one_sided(target: CharacterController):
	await action_controller.perform_approach_one_sided_action(self, target)


func approach_target_two_sided(target: CharacterController):
	await action_controller.perform_approach_two_sided_action(self, target)
#endregion


#region Combat
func perform_one_sided_attack(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as DiceData.DiceType
	match my_dice:
		DiceData.DiceType.ATTACK:
			await action_controller.perform_slash_action()
		DiceData.DiceType.GUARD:
			await action_controller.perform_guard_action()
		DiceData.DiceType.EVADE:
			await action_controller.perform_default_action()


func apply_clash_win(clash_data: ClashData):
	await win_response_helper.resolve_win_response(clash_data)


func apply_clash_lose(clash_data: ClashData):
	await lose_response_helper.resolve_lose_response(clash_data)


func apply_clash_draw(clash_data: ClashData):
	await draw_response_helper.resolve_clash_draw(clash_data)
#endregion


func roll_all_dice_slots():
		dice_slot_controller.roll_all_dice_slots()


func reset_position():
	self.position = _initial_position


func reset_visual():
	sprite.change_to_default_sprite()


func get_dice_slot_pool() -> Array[CharacterDiceSlot]:
	return dice_slot_controller.get_dice_slot_pool()
