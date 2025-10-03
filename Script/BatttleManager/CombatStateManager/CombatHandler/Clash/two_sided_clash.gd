class_name TwoSidedClash
extends IClash

var _attacker: CharacterController
var _defender: CharacterController
var _attacker_roll_value: int
var _defender_roll_value: int

func resolve(combat_data :CombatData):
	# Initialize: approach movement phase
	_attacker = combat_data.attacker
	_defender = combat_data.defender
	_attacker.get_facing().resolve_and_update_facing(_defender)
	_defender.get_facing().resolve_and_update_facing(_attacker)
	await _execute_two_sided_approach_movement(_attacker, _defender)
	_attacker.update_front_die()
	_defender.update_front_die()
	
	# Core: roll dice phase
	await _wait_for_dice_roll()
	_attacker.roll_front_die()
	_defender.roll_front_die()
	await _resolve_clash()
	
	# Finalize: resolve dice usage
	_attacker.pop_front_die()
	_defender.pop_front_die()


func _resolve_clash():
	_attacker_roll_value = _attacker.get_roll_value()
	_defender_roll_value = _defender.get_roll_value()
	
	if _attacker_roll_value > _defender_roll_value:
		Debug.log("Attacker win!")
		await _attacker.execute_front_die(_defender)
	elif _attacker_roll_value < _defender_roll_value:
		Debug.log("Defender win!")
		await _defender.execute_front_die(_attacker)
	else:
		Debug.log("Draw!")
		_attacker.execute_front_die_draw(_defender)
		await _defender.execute_front_die_draw(_attacker)


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
