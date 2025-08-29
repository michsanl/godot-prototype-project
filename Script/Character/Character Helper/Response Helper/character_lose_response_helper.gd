class_name CharacterLoseResponseHelper
extends RefCounted

var owner: CharacterController


func _init(owner: CharacterController = null) -> void:
	self.owner = owner


func resolve_lose_response(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as DiceData.DiceType
	match my_dice:
		DiceData.DiceType.ATTACK:
			await _resolve_attack_lose_response(clash_data)
		DiceData.DiceType.GUARD:
			await _resolve_guard_lose_response(clash_data)
		DiceData.DiceType.EVADE:
			await _resolve_evade_lose_response(clash_data)

#attack vs attack lose = damaged
#attack vs guard lose = damaged
#attack vs evade lose = attack
func _resolve_attack_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_damaged_action()
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_damaged_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_slash_action()

#guard vs attack lose = damaged
#guard vs guard lose = damaged
#guard vs evade lose = guard
func _resolve_guard_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_damaged_action()
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_damaged_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_guard_action()

#evade vs attack lose = damaged
#evade vs guard lose = damaged
#evade vs evade lose = default
func _resolve_evade_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_damaged_action()
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_damaged_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_default_action()
