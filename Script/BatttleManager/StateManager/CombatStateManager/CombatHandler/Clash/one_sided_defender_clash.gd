class_name OneSidedDefenderClash
extends IClash

var is_auto_roll = true
var auto_roll_timer = 1.0


func resolve(combat_data :CombatData):
	# Initialize: approach movement phase
	await _execute_one_sided_approach_movement(combat_data.defender, combat_data.attacker)
	
	# Core: roll dice phase
	await _wait_for_dice_roll()
	combat_data.roll_defender_dice()
	var defender_clash_data = ClashData.new(combat_data, ClashData.CombatRole.DEFENDER)
	await combat_data.defender.perform_one_sided_attack(defender_clash_data)
	
	# Finalize: resolve dice usage
	combat_data.defender_dice_pool.pop_front()


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
