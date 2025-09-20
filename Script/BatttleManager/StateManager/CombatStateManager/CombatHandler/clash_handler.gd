class_name ClashHandler
extends Node

enum ClashState {
	TWO_SIDED,
	ONE_SIDED_ATTACKER,
	ONE_SIDED_DEFENDER,
}

@export var two_sided: TwoSidedClash
@export var one_sided_attacker: OneSidedAttackerClash
@export var one_sided_defender: OneSidedDefenderClash


func start_combat(combat_data :CombatData):
	# TODO: Initialize - focus camera, show dice UI
	
	# Core: resolve clash until no dice left
	while combat_data.attacker_has_dice() or combat_data.defender_has_dice():
		var clash_strategy = _select_strategy(combat_data) as IClash
		if clash_strategy:
			await clash_strategy.resolve(combat_data)
		else:
			push_warning("No valid clash strategy found.")
	
	# TODO: Finalize - unfocus camera, hide dice UI


func _select_strategy(combat_data :CombatData) -> IClash:
	if combat_data.attacker_has_dice() and combat_data.defender_has_dice():
		return two_sided
	elif combat_data.attacker_has_dice():
		return one_sided_attacker
	elif combat_data.defender_has_dice():
		return one_sided_defender
	return null
