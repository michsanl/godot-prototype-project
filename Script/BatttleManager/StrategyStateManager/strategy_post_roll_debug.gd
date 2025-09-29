class_name StrategyPostRollDebug
extends IStrategyPostRoll

func execute(players: Array[CharacterController], enemies: Array[CharacterController]):
	#randomize_slots_ability(players)
	randomize_slots_ability(enemies)
	#randomize_slots_target(players, enemies)
	randomize_slots_target(enemies, players)
	

func randomize_slots_target(selections: Array[CharacterController], targets: Array[CharacterController]):
	for sources: CharacterController in selections:
		for i in range(sources.get_active_dice_slots().size()):
			var rand_slot_contr = targets.pick_random().get_slot_controller()
			var slot_index = i
			sources.set_slot_target(i, slot_index, rand_slot_contr)


func randomize_slots_ability(characters: Array[CharacterController]):
	for character: CharacterController in characters:
		for i in range(character.get_active_dice_slots().size()):
			var ability = character.get_random_ability()
			character.set_slot_ability(i, ability)
