class_name TwoSidedClash
extends IClash


func resolve(combat_data: CombatData):
	# Initialize: approach movement phase
	await _execute_two_sided_approach_movement(combat_data.attacker, combat_data.defender)
	
	# Core: roll dice phase
	await _wait_for_dice_roll()
	combat_data.roll_attacker_dice()
	combat_data.roll_defender_dice()
	await combat_data.resolve_clash()
	
	# Finalize: resolve dice usage
	combat_data.attacker_dice_pool.pop_front()
	combat_data.defender_dice_pool.pop_front()


func _execute_two_sided_approach_movement(attacker: CharacterController, defender: CharacterController):
	attacker.approach_target_two_sided(defender)
	await defender.approach_target_two_sided(attacker)


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


#func _resolve_clash_result(combat_data: CombatData):
	##var attacker_clash_data = ClashData.new(combat_data, ClashData.CombatRole.ATTACKER)
	##var defender_clash_data = ClashData.new(combat_data, ClashData.CombatRole.DEFENDER)
	#var attacker = combat_data.attacker
	#var defender = combat_data.defender
#
	#
	#if combat_data.attacker_roll_value > combat_data.defender_roll_value:
		## Attacker win
		#await combat_data.get_attacker_front_dice().execute(attacker, defender)
		##await combat_data.attacker.apply_clash_win(attacker_clash_data)
	#elif combat_data.attacker_roll_value < combat_data.defender_roll_value:
		## Defender 
		#await combat_data.get_attacker_front_dice().execute(defender, attacker)
		##await combat_data.defender.apply_clash_win(defender_clash_data)
	#else:
		## Draw
		#combat_data.get_attacker_front_dice().execute(attacker, defender)
		#await combat_data.get_attacker_front_dice().execute(defender, attacker)
