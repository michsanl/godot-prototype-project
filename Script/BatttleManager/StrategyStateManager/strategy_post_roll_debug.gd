class_name StrategyPostRollDebug
extends IStrategyPostRoll

func execute(players: Array[CharacterController], enemies: Array[CharacterController]):
	randomize_slots_ability(players)
	randomize_slots_ability(enemies)
	randomize_slots_target(players, enemies)
	randomize_slots_target(enemies, players)
	

func randomize_slots_target(selections: Array[CharacterController], targets: Array[CharacterController]):
	for selection: CharacterController in selections:
		for i in range(selection.get_active_slots().size()):
			var rand_slot = targets.pick_random().get_random_dice_slot()
			selection.set_slot_target(i, rand_slot)
	


func randomize_slots_ability(characters: Array[CharacterController]):
	for character: CharacterController in characters:
		for i in range(character.get_active_slots().size()):
			var ability = character.get_random_ability()
			character.set_slot_ability(i, ability)
