class_name CharacterWinResponseHelper
extends RefCounted

var owner: CharacterController
var my_dice_type: IDice.DiceType
var opponent: CharacterController
var opponent_dice: IDice.DiceType
var clash_data: ClashData

func _init(new_owner: CharacterController = null) -> void:
	owner = new_owner


func resolve_win_response(clash_data: ClashData):
	initialize_data(clash_data)
	match my_dice_type:
		IDice.DiceType.SLASH:
			await _resolve_attack_win_response()
		IDice.DiceType.GUARD:
			await _resolve_guard_win_response()
		IDice.DiceType.EVADE:
			await _resolve_evade_win_response()


func initialize_data(clash_data: ClashData):
	my_dice_type = clash_data.owner_dice.dice_type as IDice.DiceType
	opponent = clash_data.opponent
	opponent_dice = clash_data.opponent_dice.dice_type as IDice.DiceType
	self.clash_data = clash_data


#region Resolve Opponent Dice Type
# attack vs attack win = attack 
# attack vs guard win = attack
# attack vs evade win = attack
func _resolve_attack_win_response():
	match opponent_dice:
		IDice.DiceType.SLASH:
			pass
		IDice.DiceType.GUARD:
			pass
		IDice.DiceType.EVADE:
			pass

# guard vs attack win = guard
# guard vs guard win = guard
# guard vs evade win = guard
func _resolve_guard_win_response():
	match opponent_dice:
		IDice.DiceType.SLASH:
			await owner.action_controller.perform_guard_action()
		IDice.DiceType.GUARD:
			await owner.action_controller.perform_guard_action()
		IDice.DiceType.EVADE:
			await owner.action_controller.perform_guard_action()

# evade vs attack win = evade
# evade vs guard win = evade
# evade vs evade win = default
func _resolve_evade_win_response():
	match opponent_dice:
		IDice.DiceType.SLASH:
			await owner.action_controller.perform_evade_action()
		IDice.DiceType.GUARD:
			await owner.action_controller.perform_evade_action()
		IDice.DiceType.EVADE:
			await owner.action_controller.perform_default_action()
#endregion
