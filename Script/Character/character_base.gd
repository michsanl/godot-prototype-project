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
@export var attack_token_response: AttackTokenReseponse
@export var evade_token_response: EvadeTokenReseponse
@export var guard_token_response: GuardTokenReseponse

@onready var initial_position: Vector2 = self.position


func reset_position():
	self.position = initial_position


func reset_visual():
	character_action.reset_visual()


#region Combat State Methods
func get_random_ability():
	return ability_manager.get_random_ability()


func get_current_target():
	character_targeting.current_target


func move_towards_primary_target():
	# TODO: 
	# move to highest speed dice target
	# set facing direction to highest speed dice target
	# stop when raching target clash trigger zone
	pass


func move_towards_clash_target():
	# TODO:
	# move to clash target adjecent
	pass
#endregion


func roll_all_dice_slot_speed() -> void:
	dice_slot_controller.roll_all_dice_slot()


func get_random_dice_slot():
	var dice_slot_pool = dice_slot_controller.get_dice_slot_pool() as Array[CharacterDiceSlot]
	var random_dice_slot = dice_slot_pool.pick_random() as CharacterDiceSlot
	return random_dice_slot


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
