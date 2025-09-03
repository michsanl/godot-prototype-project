class_name CombatData
extends RefCounted

enum ClashResult { WIN, LOSE, DRAW }

var attacker: CharacterController # character with higher speed
var attacker_dice_slot: CharacterDiceSlot
var attacker_ability: AbilityData
var attacker_dice_pool: Array[DiceData] = []
var attacker_roll_value: int
var attacker_clash_result: ClashResult

var defender: CharacterController # character with lower speed
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


func attacker_has_dice() -> bool:
	return attacker_dice_pool.size() > 0


func defender_has_dice() -> bool:
	return defender_dice_pool.size() > 0


func roll_attacker_dice():
	attacker_roll_value = attacker_dice_pool.front().roll_dice()
	print("Attacker roll: ", attacker_roll_value)


func roll_defender_dice():
	defender_roll_value = defender_dice_pool.front().roll_dice()
	print("Defender roll: ", defender_roll_value)


func calculate_clash_result():
	if attacker_roll_value > defender_roll_value:
		print("Attacker win!")
		attacker_clash_result = ClashResult.WIN
		defender_clash_result = ClashResult.LOSE
	elif attacker_roll_value < defender_roll_value:
		print("Defender win!")
		attacker_clash_result = ClashResult.LOSE
		defender_clash_result = ClashResult.WIN
	else:
		print("Draw!")
		attacker_clash_result = ClashResult.DRAW
		defender_clash_result = ClashResult.DRAW


func get_attacker_front_dice() -> DiceData:
	if attacker_dice_pool.is_empty():
		return null
	return attacker_dice_pool.front()
	


func get_defender_front_dice() -> DiceData:
	if defender_dice_pool.is_empty():
		return null
	return defender_dice_pool.front()


func _set_attacker_combat_data(dice_slot: CharacterDiceSlot):
	attacker = dice_slot.owner as CharacterController
	attacker_dice_slot = dice_slot.duplicate()
	attacker_ability = dice_slot.selected_ability.duplicate()
	attacker_dice_pool = attacker_ability.get_dice_pool().duplicate() as Array[DiceData]


func _set_defender_combat_data(dice_slot: CharacterDiceSlot):
	defender = dice_slot.owner as CharacterController
	defender_dice_slot = dice_slot.duplicate()
	defender_ability = dice_slot.selected_ability.duplicate()
	defender_dice_pool = defender_ability.get_dice_pool().duplicate() as Array[DiceData]
