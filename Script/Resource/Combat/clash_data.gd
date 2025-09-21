class_name ClashData
extends RefCounted

enum ClashResult { WIN, LOSE, DRAW }
enum CombatRole { ATTACKER, DEFENDER }

var clash_result: ClashResult
var owner: CharacterController
var owner_dice: IDice
var owner_dice_value: int
var opponent: CharacterController
var opponent_dice: IDice
var opponent_dice_value: int


func _init(combat_data: CombatData = null, role: CombatRole = CombatRole.ATTACKER) -> void:
	match role:
		CombatRole.ATTACKER:
			_set_attacker_clash_data(combat_data)
		CombatRole.DEFENDER:
			_set_defender_clash_data(combat_data)


func _set_attacker_clash_data(combat_data: CombatData):
	clash_result = ClashData.ClashResult.values()[combat_data.attacker_clash_result]
	owner = combat_data.attacker as CharacterController
	owner_dice = combat_data.get_attacker_front_dice()
	owner_dice_value = combat_data.attacker_roll_value as int
	opponent = combat_data.defender as CharacterController
	opponent_dice = combat_data.get_defender_front_dice()
	opponent_dice_value = combat_data.defender_roll_value


func _set_defender_clash_data(combat_data: CombatData):
	clash_result = ClashData.ClashResult.values()[combat_data.defender_clash_result]
	owner = combat_data.defender as CharacterController
	owner_dice = combat_data.get_defender_front_dice()
	owner_dice_value = combat_data.defender_roll_value as int
	opponent = combat_data.attacker as CharacterController
	opponent_dice = combat_data.get_attacker_front_dice()
	opponent_dice_value = combat_data.attacker_roll_value
