extends Node

enum battle_state {BATTLE_STRATEGY, BATTLE_COMBAT, BATTLE_RESOLVE}

@export var current_state: battle_state

signal strategy_phase_started
signal combat_phase_started
signal resolve_phase_started
signal on_strategy_exit
signal on_combat_exit
signal on_resolve_exit

func _ready() -> void:
	print("started")

func set_battle_state_to_strategy():
	set_battle_state(battle_state.BATTLE_STRATEGY)
	
func set_battle_state_to_combat():
	set_battle_state(battle_state.BATTLE_COMBAT)
	
func set_battle_state_to_resolve():
	set_battle_state(battle_state.BATTLE_RESOLVE)

func set_battle_state(new_state: battle_state) -> void:
	match current_state:
		battle_state.BATTLE_STRATEGY:
			on_strategy_exit.emit()
		battle_state.BATTLE_COMBAT:
			on_combat_exit.emit()
		battle_state.BATTLE_RESOLVE:
			on_resolve_exit.emit()
	
	current_state = new_state
	
	match current_state:
		battle_state.BATTLE_STRATEGY:
			strategy_phase_started.emit()
		battle_state.BATTLE_COMBAT:
			combat_phase_started.emit()
		battle_state.BATTLE_RESOLVE:
			resolve_phase_started.emit()
