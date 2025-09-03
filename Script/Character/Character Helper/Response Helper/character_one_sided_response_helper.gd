class_name CharacterOneSidedResponseHelper
extends RefCounted

var owner: CharacterController


func _init(owner_chara: CharacterController = null) -> void:
	self.owner = owner_chara


func resolve_one_sided_response(clash_data: ClashData):
	var my_dice = clash_data.owner_dice.dice_type as DiceData.DiceType
	match my_dice:
		DiceData.DiceType.ATTACK:
			await owner.action_controller.perform_slash_action(clash_data.opponent)
		DiceData.DiceType.GUARD:
			await owner.action_controller.perform_guard_action()
		DiceData.DiceType.EVADE:
			await owner.action_controller.perform_default_action()
