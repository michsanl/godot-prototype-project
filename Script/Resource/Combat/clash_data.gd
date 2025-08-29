class_name ClashData
extends RefCounted

enum ClashResult { WIN, LOSE, DRAW }
enum CombatRole { ATTACKER, DEFENDER }

var clash_result: ClashResult
var owner: CharacterBase
var owner_dice: DiceData
var owner_dice_value: int
var opponent: CharacterBase
var opponent_dice: DiceData
var opponent_dice_value: int


func _init(combat_data: CombatData = null, role: CombatRole = CombatRole.ATTACKER) -> void:
	match role:
		CombatRole.ATTACKER:
			_set_attacker_clash_data(combat_data)
		CombatRole.DEFENDER:
			_set_defender_clash_data(combat_data)


func _set_attacker_clash_data(combat_data: CombatData):
	clash_result = combat_data.attacker_clash_result as int
	owner = combat_data.attacker as CharacterBase
	owner_dice = combat_data.attacker_dice_pool[0] as DiceData 
	owner_dice_value = combat_data.attacker_roll_value as int
	opponent = combat_data.defender as CharacterBase
	opponent_dice = combat_data.defender_dice_pool[0] as DiceData
	opponent_dice_value = combat_data.defender_roll_value


func _set_defender_clash_data(combat_data: CombatData):
	clash_result = combat_data.attacker_clash_result as int
	owner = combat_data.attacker as CharacterBase
	owner_dice = combat_data.attacker_dice_pool[0] as DiceData 
	owner_dice_value = combat_data.attacker_roll_value as int
	opponent = combat_data.defender as CharacterBase
	opponent_dice = combat_data.defender_dice_pool[0] as DiceData
	opponent_dice_value = combat_data.defender_roll_value
