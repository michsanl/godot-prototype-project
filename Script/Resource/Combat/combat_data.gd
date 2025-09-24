class_name CombatData
extends RefCounted

var attacker: CharacterController # character with higher speed
var defender: CharacterController # character with lower speed

func _init(attacker_slot: DiceSlotData = null, defender_slot: DiceSlotData = null):
	attacker = attacker_slot.get_owner()
	defender = defender_slot.get_owner()
