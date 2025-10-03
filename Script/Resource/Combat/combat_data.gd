class_name CombatData
extends RefCounted

var attacker: CharacterController # character with higher speed
var defender: CharacterController # character with lower speed
var attacker_dice_slot: DiceSlotData
var defender_dice_slot: DiceSlotData
var combatant: Array[Node2D] = []

func _init(attacker_slot: DiceSlotData = null, defender_slot: DiceSlotData = null):
	attacker_dice_slot = attacker_slot
	defender_dice_slot = defender_slot
	attacker = attacker_slot.get_owner()
	defender = defender_slot.get_owner()
	combatant.append(attacker)
	combatant.append(defender)
