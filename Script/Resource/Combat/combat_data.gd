class_name CombatData
extends RefCounted

enum ClashResult { WIN, LOSE, DRAW }

var attacker: CharacterController # character with higher speed
var attacker_dice_slot: DiceSlotData
var attacker_ability: AbilityData
var attacker_dice_pool: Array[IDice] = []
var attacker_roll_value: int
var attacker_clash_result: ClashResult

var defender: CharacterController # character with lower speed
var defender_dice_slot: DiceSlotData
var defender_ability: AbilityData
var defender_dice_pool: Array[IDice] = []
var defender_roll_value: int
var defender_clash_result: ClashResult


func _init(attacker_slot: DiceSlotData = null, defender_slot: DiceSlotData = null):
	if attacker_slot:
		_set_attacker_combat_data(attacker_slot)
	if defender_slot:
		_set_defender_combat_data(defender_slot)


func attacker_has_dice() -> bool:
	return attacker_dice_pool.size() > 0


func defender_has_dice() -> bool:
	return defender_dice_pool.size() > 0


func roll_attacker_dice():
	var front_dice = attacker_dice_pool.front() as IDice
	attacker_roll_value = front_dice.get_roll_value()
	print("Attacker roll: ", attacker_roll_value)


func roll_defender_dice():
	var front_dice = defender_dice_pool.front() as IDice
	defender_roll_value = front_dice.get_roll_value()
	print("Defender roll: ", defender_roll_value)


func resolve_clash():
	if attacker_roll_value > defender_roll_value:
		print("Attacker win!")
		attacker_clash_result = ClashResult.WIN
		defender_clash_result = ClashResult.LOSE
		await get_attacker_front_dice().execute(attacker, defender)
	elif attacker_roll_value < defender_roll_value:
		print("Defender win!")
		attacker_clash_result = ClashResult.LOSE
		defender_clash_result = ClashResult.WIN
		await get_defender_front_dice().execute(defender, attacker)
	else:
		print("Draw!")
		attacker_clash_result = ClashResult.DRAW
		defender_clash_result = ClashResult.DRAW
		get_attacker_front_dice().execute_draw(attacker, defender)
		await get_defender_front_dice().execute_draw(defender, attacker)


func get_attacker_front_dice() -> IDice:
	if attacker_dice_pool.is_empty():
		return null
	return attacker_dice_pool.front()
	


func get_defender_front_dice() -> IDice:
	if defender_dice_pool.is_empty():
		return null
	return defender_dice_pool.front()


func _set_attacker_combat_data(dice_slot: DiceSlotData):
	attacker = dice_slot.owner_character as CharacterController
	attacker_dice_slot = dice_slot
	attacker_ability = dice_slot.selected_ability.duplicate()
	attacker_dice_pool = attacker_ability.get_dice_pool().duplicate() as Array[IDice]
	defender = dice_slot.target_dice_slot.owner_character as CharacterController


func _set_defender_combat_data(dice_slot: DiceSlotData):
	defender = dice_slot.owner_character as CharacterController
	defender_dice_slot = dice_slot
	defender_ability = dice_slot.selected_ability.duplicate()
	defender_dice_pool = defender_ability.get_dice_pool().duplicate() as Array[IDice]
