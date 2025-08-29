class_name CharacterWinResponseHelper
extends RefCounted

var _owner: CharacterController


func _init(owner: CharacterController = null) -> void:
	_owner = owner


func resolve_win_response(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as DiceData.DiceType
	match my_dice:
		DiceData.DiceType.ATTACK:
			await _resolve_attack_win_response(clash_data)
		DiceData.DiceType.GUARD:
			await _resolve_guard_win_response(clash_data)
		DiceData.DiceType.EVADE:
			await _resolve_evade_win_response(clash_data)

# attack vs attack win = attack 
# attack vs guard win = attack
# attack vs evade win = attack
func _resolve_attack_win_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await _owner.action_controller.perform_slash_action()
		DiceData.DiceType.GUARD:
			await _owner.action_controller.perform_slash_action()
		DiceData.DiceType.EVADE:
			await _owner.action_controller.perform_slash_action()

# guard vs attack win = guard
# guard vs guard win = guard
# guard vs evade win = guard
func _resolve_guard_win_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await _owner.action_controller.perform_guard_action()
		DiceData.DiceType.GUARD:
			await _owner.action_controller.perform_guard_action()
		DiceData.DiceType.EVADE:
			await _owner.action_controller.perform_guard_action()

# evade vs attack win = evade
# evade vs guard win = evade
# evade vs evade win = default
func _resolve_evade_win_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await _owner.action_controller.perform_evade_action()
		DiceData.DiceType.GUARD:
			await _owner.action_controller.perform_evade_action()
		DiceData.DiceType.EVADE:
			await _owner.action_controller.perform_default_action()
