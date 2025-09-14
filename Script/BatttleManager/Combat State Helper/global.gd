extends Node

enum BattleState { NOTSET, STRATEGY, COMBAT, RESOLVE }

signal strategy_started
signal combat_started
signal resolve_started


func enter_state(new_state: BattleState) -> void:
	match new_state:
		BattleState.NOTSET:
			return
		BattleState.STRATEGY:
			strategy_started.emit()
			return
		BattleState.COMBAT:
			combat_started.emit()
			return
		BattleState.RESOLVE:
			resolve_started.emit()
			return
