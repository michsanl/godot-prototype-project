class_name CharacterWinResponseHelper
extends RefCounted

var owner: CharacterController
var my_dice: DiceData.DiceType
var my_offensive_type: DiceData.OffensiveType
var opponent_dice: DiceData.DiceType


func _init(new_owner: CharacterController = null) -> void:
	owner = new_owner


func resolve_win_response(clash_data: ClashData):
	initialize_data(clash_data)
	match my_dice:
		DiceData.DiceType.ATTACK:
			await _resolve_attack_win_response()
		DiceData.DiceType.GUARD:
			await _resolve_guard_win_response()
		DiceData.DiceType.EVADE:
			await _resolve_evade_win_response()


func initialize_data(clash_data: ClashData):
	my_dice = clash_data.owner_dice.dice_type as DiceData.DiceType
	my_offensive_type = clash_data.owner_dice.offensive_type as DiceData.OffensiveType
	opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType


#region Resolve Opponent Dice Type
# attack vs attack win = attack 
# attack vs guard win = attack
# attack vs evade win = attack
func _resolve_attack_win_response():
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_random_offensive_action()
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_random_offensive_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_random_offensive_action()

# guard vs attack win = guard
# guard vs guard win = guard
# guard vs evade win = guard
func _resolve_guard_win_response():
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_guard_action()
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_guard_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_guard_action()

# evade vs attack win = evade
# evade vs guard win = evade
# evade vs evade win = default
func _resolve_evade_win_response():
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_evade_action()
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_evade_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_default_action()
#endregion


func _resolve_offensive_type(clash_data: ClashData):
	match my_offensive_type:
		DiceData.OffensiveType.SLASH:
			await owner.action_controller.perform_slash_action()
		DiceData.OffensiveType.PIERCE:
			await owner.action_controller.perform_pierce_action()
		DiceData.OffensiveType.BLUNT:
			await owner.action_controller.perform_blunt_action()
