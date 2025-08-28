class_name CombatData
extends Object

enum ClashResult { WIN, LOSE, DRAW }

var attacker: CharacterBase # character with higher speed
var attacker_dice_slot: CharacterDiceSlot
var attacker_ability: AbilityData
var attacker_dice_pool: Array[DiceData] = []
var attacker_roll_value: int
var attacker_clash_result: ClashResult

var defender: CharacterBase # character with lower speed
var defender_dice_slot: CharacterDiceSlot
var defender_ability: AbilityData
var defender_dice_pool: Array[DiceData] = []
var defender_roll_value: int
var defender_clash_result: ClashResult


func _init(attacker_slot: CharacterDiceSlot = null, defender_slot: CharacterDiceSlot = null):
	if attacker_slot:
		_set_attacker_combat_data(attacker_slot)
	if defender_slot:
		_set_defender_combat_data(defender_slot)


func roll_attacker_dice():
	attacker_roll_value = attacker_dice_pool[0].roll_dice()


func roll_defender_dice():
	defender_roll_value = defender_dice_pool[0].roll_dice()


func resolve_clash_result():
	if attacker_roll_value > defender_roll_value:
		attacker_clash_result = ClashResult.WIN
		defender_clash_result = ClashResult.LOSE
	elif attacker_roll_value < defender_roll_value:
		attacker_clash_result = ClashResult.LOSE
		defender_clash_result = ClashResult.WIN
	else:
		attacker_clash_result = ClashResult.DRAW
		defender_clash_result = ClashResult.DRAW


func _set_attacker_combat_data(dice_slot: CharacterDiceSlot):
	attacker = dice_slot.owner_character as CharacterBase
	attacker_dice_slot = dice_slot
	attacker_ability = dice_slot.selected_ability
	attacker_dice_pool = dice_slot.selected_ability.get_dice_pool()


func _set_defender_combat_data(dice_slot: CharacterDiceSlot):
	defender = dice_slot.owner_character as CharacterBase
	defender_dice_slot = dice_slot
	defender_ability = dice_slot.selected_ability
	defender_dice_pool = dice_slot.selected_ability.get_dice_pool()
