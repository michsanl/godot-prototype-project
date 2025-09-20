class_name OneSidedAttackerClash
extends IClash


func resolve(combat_data :CombatData):
	# Initialize: approach movement phase
	await _execute_one_sided_approach_movement(combat_data.attacker, combat_data.defender)
	
	# Core: roll dice phase
	await _wait_for_dice_roll()
	combat_data.roll_attacker_dice()
	await combat_data.get_defender_front_dice().execute(combat_data.attacker, combat_data.defender)
	
	# Finalize: resolve dice usage
	combat_data.attacker_dice_pool.pop_front()


func _execute_one_sided_approach_movement(attacker: CharacterController, defender: CharacterController):
	await attacker.approach_target_one_sided(defender)


func _wait_for_dice_roll():
	if not is_auto_roll:
		await _wait_for_space()
	else:
		await _wait_for_timer(auto_roll_timer)


func _wait_for_space():
	while true:
		await get_tree().physics_frame
		if Input.is_key_pressed(KEY_SPACE):
			break

func _wait_for_timer(duration: float):
	await get_tree().create_timer(duration).timeout
