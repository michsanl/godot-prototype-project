class_name CharacterDrawResponseHelper
extends RefCounted

var owner: CharacterController


func _init(owner_chara: CharacterController = null) -> void:
	self.owner = owner_chara


func resolve_clash_draw(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as IDice.DiceType
	match my_dice:
		IDice.DiceType.SLASH:
			await _resolve_attack_draw_response(clash_data)
		IDice.DiceType.GUARD:
			await _resolve_guard_draw_response(clash_data)
		IDice.DiceType.EVADE:
			await _resolve_evade_draw_response(clash_data)

#attack vs attack draw = attack
#attack vs guard draw = attack
#attack vs evade draw = attack
func _resolve_attack_draw_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as IDice.DiceType
	match opponent_dice:
		IDice.DiceType.SLASH:
			await owner.action_controller.perform_slash_action(clash_data.opponent, true)
		IDice.DiceType.GUARD:
			await owner.action_controller.perform_pierce_action(clash_data.opponent, true)
		IDice.DiceType.EVADE:
			await owner.action_controller.perform_blunt_action(clash_data.opponent, true)


#guard vs attack draw = guard
#guard vs guard draw = guard
#guard vs evade draw = guard
func _resolve_guard_draw_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as IDice.DiceType
	match opponent_dice:
		IDice.DiceType.SLASH:
			await owner.action_controller.perform_guard_action()
		IDice.DiceType.GUARD:
			await owner.action_controller.perform_guard_action()
		IDice.DiceType.EVADE:
			await owner.action_controller.perform_guard_action()

#evade vs attack draw = evade
#evade vs guard draw = evade
#evade vs evade draw = default 
func _resolve_evade_draw_response(clash_data: ClashData):
	var opponent_dice = clash_data.opponent_dice.dice_type as IDice.DiceType
	match opponent_dice:
		IDice.DiceType.SLASH:
			await owner.action_controller.perform_evade_action()
		IDice.DiceType.GUARD:
			await owner.action_controller.perform_evade_action()
		IDice.DiceType.EVADE:
			await owner.action_controller.perform_default_action()
