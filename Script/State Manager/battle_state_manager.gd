class_name StateManager
extends Node

enum BattleState { NOTSET, STRATEGY, COMBAT, RESOLVE }

@export var strategy_state_manager: StrategyStateManager
@export var combat_state_manager: CombatStateManager

var _current_state: BattleState


func _on_combat_state_manager_combat_ended() -> void:
	change_state_to_resolve()


func _on_strategy_button_pressed() -> void:
	change_state_to_strategy()


func _on_combat_button_pressed() -> void:
	change_state_to_combat()


func _on_resolve_button_pressed() -> void:
	change_state_to_resolve()


func change_state_to_strategy():
	_change_state(BattleState.STRATEGY)


func change_state_to_combat():
	_change_state(BattleState.COMBAT)


func change_state_to_resolve():
	_change_state(BattleState.RESOLVE)


#region State Change Region
func _change_state(new_state: BattleState) -> void:
	_exit_state()
	_set_state(new_state)
	_enter_state()


func _enter_state() -> void:
	match _current_state:
		BattleState.NOTSET:
			return
		BattleState.STRATEGY:
			strategy_state_manager.handle_strategy_state_enter()
			return
		BattleState.COMBAT:
			combat_state_manager.handle_combat_state_enter()
			return
		BattleState.RESOLVE:
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
