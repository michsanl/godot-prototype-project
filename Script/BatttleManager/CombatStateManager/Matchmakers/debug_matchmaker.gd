class_name DebugMatchmaker
extends ICombatMatchmaker


func initialize(dice_slots: Array[DiceSlotData]):
	_sort_dice_slots_by_higher_speed(dice_slots)


func resolve(character_slots: Array[DiceSlotData]) -> CombatData:
	# Get combat pair
	var attacker_dice_slot = character_slots.front() as DiceSlotData
	var defender_dice_slot = attacker_dice_slot.target_dice_slot as DiceSlotData
	# Commit combat pair & initialize combat data
	if defender_dice_slot.target_dice_slot == attacker_dice_slot:
		print("Defender target is Attacker")
		character_slots.erase(attacker_dice_slot)
		character_slots.erase(defender_dice_slot)
		attacker_dice_slot.get_owner().initialize_combat(attacker_dice_slot)
		defender_dice_slot.get_owner().initialize_combat(defender_dice_slot)
	else:
		print("Defender target is NOT Attacker")
		character_slots.erase(attacker_dice_slot)
		attacker_dice_slot.get_owner().initialize_combat(attacker_dice_slot)
	
	# Create combat data
	var combat_data = CombatData.new(attacker_dice_slot, defender_dice_slot)
	return combat_data


func _sort_dice_slots_by_higher_speed(dice_slots: Array[DiceSlotData]):
	dice_slots.sort_custom(sort_ascending_dice_slot_speed)


func sort_ascending_dice_slot_speed(a: DiceSlotData, b: DiceSlotData) -> bool:
	return a.speed_value > b.speed_value
