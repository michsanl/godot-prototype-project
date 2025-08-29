class_name CharacterLoseResponseHelper
extends RefCounted

var _response_controller: CharacterResponseController


func _init(response_controller: CharacterResponseController = null) -> void:
	_response_controller = response_controller


func resolve_lose_response(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as DiceData.DiceType
	match my_dice:
		DiceData.DiceType.ATTACK:
			await _resolve_attack_lose_response(clash_data)
		DiceData.DiceType.GUARD:
			await _resolve_guard_lose_response(clash_data)
		DiceData.DiceType.EVADE:
			await _resolve_evade_lose_response(clash_data)


func _resolve_attack_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			pass
		DiceData.DiceType.GUARD:
			pass
		DiceData.DiceType.EVADE:
			pass


func _resolve_guard_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			pass
		DiceData.DiceType.GUARD:
			pass
		DiceData.DiceType.EVADE:
			pass


func _resolve_evade_lose_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as DiceData.DiceType
	match opponent_dice:
		DiceData.DiceType.ATTACK:
			pass
		DiceData.DiceType.GUARD:
			pass
		DiceData.DiceType.EVADE:
			pass
