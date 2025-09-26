class_name CharacterLoseResponseHelper
extends RefCounted

var owner: CharacterController


func _init(owner_chara: CharacterController = null) -> void:
	self.owner = owner_chara


func resolve_lose_response(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as BaseDice.DiceType
	match my_dice:
		BaseDice.DiceType.SLASH:
			await _resolve_attack_lose_response(clash_data)
		BaseDice.DiceType.GUARD:
			await _resolve_guard_lose_response(clash_data)
		BaseDice.DiceType.EVADE:
			await _resolve_evade_lose_response(clash_data)

#attack vs attack lose = damaged
#attack vs guard lose = damaged
#attack vs evade lose = attack
func _resolve_attack_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as BaseDice.DiceType
	match opponent_dice:
		BaseDice.DiceType.SLASH:
			await owner.action_controller.perform_damaged_action()
		BaseDice.DiceType.GUARD:
			await owner.action_controller.perform_damaged_action()
		BaseDice.DiceType.EVADE:
			await owner.action_controller.perform_random_offensive_action(clash_data.opponent)

#guard vs attack lose = damaged
#guard vs guard lose = damaged
#guard vs evade lose = guard
func _resolve_guard_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as BaseDice.DiceType
	match opponent_dice:
		BaseDice.DiceType.SLASH:
			await owner.action_controller.perform_damaged_action()
		BaseDice.DiceType.GUARD:
			await owner.action_controller.perform_damaged_action()
		BaseDice.DiceType.EVADE:
			await owner.action_controller.perform_guard_action()

#evade vs attack lose = damaged
#evade vs guard lose = damaged
#evade vs evade lose = default
func _resolve_evade_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as BaseDice.DiceType
	match opponent_dice:
		BaseDice.DiceType.SLASH:
			await owner.action_controller.perform_damaged_action()
		BaseDice.DiceType.GUARD:
			await owner.action_controller.perform_damaged_action()
		BaseDice.DiceType.EVADE:
			await owner.action_controller.perform_default_action()
