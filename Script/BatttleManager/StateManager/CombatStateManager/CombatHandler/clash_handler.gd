class_name ClashHandler
extends Node

enum ClashState {
	TWO_SIDED,
	ONE_SIDED_ATTACKER,
	ONE_SIDED_DEFENDER,
}

@export var two_sided: IClash
@export var one_sided_attacker: IClash
@export var one_sided_defender: IClash

var _attacker: CharacterController
var _defender: CharacterController

func start_combat(combat_data :CombatData):
	# TODO: Initialize - focus camera, show dice UI
	_attacker = combat_data.attacker
	_defender = combat_data.defender
	
	# Core: resolve clash until no dice left
	while _attacker.has_dice() or _defender.has_dice():
		var clash_strategy: IClash = _select_strategy()
		if clash_strategy:
			await clash_strategy.resolve(combat_data)
		else:
			push_warning("No valid clash strategy found.")
	
	# TODO: Finalize - unfocus camera, hide dice UI


func _select_strategy() -> IClash:
	if _attacker.has_dice() and _defender.has_dice():
		return two_sided
	elif _attacker.has_dice():
		return one_sided_attacker
	elif _defender.has_dice():
		return one_sided_defender
	return null
