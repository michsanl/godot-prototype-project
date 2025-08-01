extends Node

signal strategy_phase_started
signal combat_phase_started
signal resolve_phase_started
signal strategy_phase_ended
signal combat_phase_ended
signal resolve_phase_ended

enum BattleState { BATTLE_STRATEGY, BATTLE_COMBAT, BATTLE_RESOLVE }

var _current_state: BattleState

func change_state_to_strategy():
	_change_state(BattleState.BATTLE_STRATEGY)


func change_state_to_combat():
	_change_state(BattleState.BATTLE_COMBAT)


func change_state_to_resolve():
	_change_state(BattleState.BATTLE_RESOLVE)


#region State Change Region
func _change_state(new_state: BattleState) -> void:
	_exit_state()
	_set_state(new_state)
	_enter_state()


func _exit_state() -> void:
	match _current_state:
		BattleState.BATTLE_STRATEGY:
			strategy_phase_ended.emit()
		BattleState.BATTLE_COMBAT:
			combat_phase_ended.emit()
		BattleState.BATTLE_RESOLVE:
			resolve_phase_ended.emit()


func _set_state(new_state: BattleState) -> void:
	_current_state = new_state
	print("Battle state changed to: ", new_state)


func _enter_state() -> void:
	match _current_state:
		BattleState.BATTLE_STRATEGY:
			strategy_phase_started.emit()
		BattleState.BATTLE_COMBAT:
			combat_phase_started.emit()
		BattleState.BATTLE_RESOLVE:
			resolve_phase_started.emit()
#endregion
