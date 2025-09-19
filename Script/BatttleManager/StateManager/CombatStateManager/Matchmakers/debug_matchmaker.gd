class_name DebugMatchmaker
extends ICombatMatchmaker


func initialize(dice_slots: Array[DiceSlotData]):
	_sort_dice_slots_by_higher_speed(dice_slots)


func resolve(characters: Array[DiceSlotData]) -> CombatData:
	# Get combat pair
	var attacker_dice_slot = characters.front() as DiceSlotData
	var defender_dice_slot = attacker_dice_slot.target_dice_slot as DiceSlotData
	var combat_data: CombatData
	
	# Commit combat pair & Create combat data
	if defender_dice_slot.target_dice_slot == attacker_dice_slot:
		characters.erase(attacker_dice_slot)
		characters.erase(defender_dice_slot)
		combat_data = CombatData.new(attacker_dice_slot, defender_dice_slot)
	else:
		characters.erase(attacker_dice_slot)
		combat_data = CombatData.new(attacker_dice_slot)
	
	# Create combat data
	
	return combat_data


func _sort_dice_slots_by_higher_speed(dice_slots: Array[DiceSlotData]):
	dice_slots.sort_custom(sort_ascending_dice_slot_speed)


func sort_ascending_dice_slot_speed(a: DiceSlotData, b: DiceSlotData) -> bool:
	return a.speed_value > b.speed_value
