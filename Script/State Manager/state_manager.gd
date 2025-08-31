#class_name StateManager
extends Node

enum BattleState { NOTSET, STRATEGY, COMBAT, RESOLVE }

signal strategy_started
signal combat_started
signal resolve_started

@export var strategy_state_manager: StrategyStateManager
@export var combat_state_manager: CombatStateManager

var _current_state: BattleState


func change_state_to_strategy():
	_change_state(BattleState.STRATEGY)


func change_state_to_combat():
	_change_state(BattleState.COMBAT)


func change_state_to_resolve():
	_change_state(BattleState.RESOLVE)


#region State Change Region
func _change_state(target_state: BattleState) -> void:
	if is_changing_to_same_state(target_state):
		return
	
	_exit_state()
	_set_state(target_state)
	_enter_state()


func _enter_state() -> void:
	match _current_state:
		BattleState.NOTSET:
			return
		BattleState.STRATEGY:
			strategy_state_manager.handle_strategy_state_enter()
			strategy_started.emit()
			return
		BattleState.COMBAT:
			combat_state_manager.handle_combat_state_enter()
			combat_started.emit()
			return
		BattleState.RESOLVE:
			resolve_started.emit()
			return


func _set_state(new_state: BattleState) -> void:
	_current_state = new_state
	print("Battle state changed to: ", BattleState.keys()[new_state])


func _exit_state() -> void:
	match _current_state:
		BattleState.NOTSET:
			return
		BattleState.STRATEGY:
			strategy_state_manager.handle_strategy_state_exit()
			return
		BattleState.COMBAT:
			combat_state_manager.handle_combat_state_exit()
			return
		BattleState.RESOLVE:
			return
#endregion


func is_changing_to_same_state(target_state: BattleState) -> bool:
	return target_state == _current_state


func _on_combat_state_manager_combat_ended() -> void:
	change_state_to_resolve()
