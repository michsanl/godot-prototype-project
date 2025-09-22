class_name OneSidedDefenderClash
extends IClash


var _attacker: CharacterController
var _defender: CharacterController

func resolve(combat_data :CombatData):
	# Initialize: approach movement phase
	_attacker = combat_data.attacker
	_defender = combat_data.defender
	await _defender.approach_target_one_sided(_attacker)
	
	# Core: roll dice phase
	await _wait_for_dice_roll()
	_defender.roll_front_die()
	await _defender.execute_front_die(_attacker)
	
	# Finalize: resolve dice usage
	_defender.pop_front_die()


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
