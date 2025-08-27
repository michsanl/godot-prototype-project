class_name CombatData
extends Resource

var attacker: CharacterBase # character with higher speed
var attacker_dice_pool: Array[DiceData] = []

var defender: CharacterBase # character with lower speed
var defender_dice_pool: Array[DiceData] = []
