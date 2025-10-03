class_name OneSidedAttackerClash
extends IClash

var _attacker: CharacterController
var _defender: CharacterController

func resolve(combat_data :CombatData):
	# Initialize: approach movement phase
	_attacker = combat_data.attacker
	_defender = combat_data.defender
	_attacker.get_facing().resolve_and_update_facing(_defender)
	_defender.get_facing().resolve_and_update_facing(_attacker)
	await _attacker.get_action_controller().perform_approach_one_sided_action(_defender)
	_attacker.update_front_die()
	
	# Core: roll dice phase
	await _wait_for_dice_roll()
	_attacker.roll_front_die()
	await _attacker.execute_front_die(_defender)
	
	# Finalize: resolve dice usage
	_attacker.pop_front_die()


#region Wait For Dice Roll Methods
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
#endregion
