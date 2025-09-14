class_name BattleManager
extends Node

enum BattleState { NOTSET, INITIALIZE, STRATEGY, COMBAT, RESOLVE, FINALIZE }

signal initialize_started
signal strategy_started
signal combat_started
signal resolve_started
signal finalize_started

@export var initialize_battle_manager: InitializeBattleManager
@export var strategy_state_manager: StrategyStateManager
@export var combat_state_manager: CombatStateManager
@export var resolve_state_manager: ResolveStateManager
#@export var finalize_battle_manager: FinalizeBattleManager

var _current_state: BattleState


func _ready() -> void:
	initialize_battle_manager.initialize_ended.connect(change_state_to_strategy)
	strategy_state_manager.strategy_ended.connect(change_state_to_combat)
	combat_state_manager.combat_ended.connect(change_state_to_resolve)
	resolve_state_manager.resolve_ended.connect(change_state_to_strategy)
	change_state_to_initialize()


func change_state_to_initialize():
	_change_state(BattleState.INITIALIZE)


func change_state_to_strategy():
	_change_state(BattleState.STRATEGY)


func change_state_to_combat():
	_change_state(BattleState.COMBAT)


func change_state_to_resolve():
	_change_state(BattleState.RESOLVE)


func change_state_to_finalize():
	_change_state(BattleState.FINALIZE)


#region State Change Region
func _change_state(target_state: BattleState) -> void:
	if is_changing_to_same_state(target_state):
		return
	
	_exit_state()
	_set_state(target_state)
	_enter_state()


func _enter_state() -> void:
	match _current_state:
		BattleState.INITIALIZE:
			initialize_battle_manager.handle_initialize_battle_enter()
			initialize_started.emit()
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
			resolve_state_manager.handle_initialize_battle_enter()
			resolve_started.emit()
			return
		BattleState.FINALIZE:
			finalize_started.emit()
			return


func _set_state(new_state: BattleState) -> void:
	_current_state = new_state
	print("Battle state changed to: ", BattleState.keys()[new_state])


func _exit_state() -> void:
	match _current_state:
		BattleState.INITIALIZE:
			initialize_battle_manager.handle_initialize_battle_exit()
			return
		BattleState.STRATEGY:
			strategy_state_manager.handle_strategy_state_exit()
			return
		BattleState.COMBAT:
			combat_state_manager.handle_combat_state_exit()
			return
		BattleState.RESOLVE:
			resolve_state_manager.handle_initialize_battle_exit()
			return
		BattleState.FINALIZE:
			return
#endregion


func is_changing_to_same_state(target_state: BattleState) -> bool:
	return target_state == _current_state
