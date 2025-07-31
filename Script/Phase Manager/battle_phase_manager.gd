extends Node

enum battle_state {BATTLE_STRATEGY, BATTLE_COMBAT, BATTLE_RESOLVE}

@export var current_state: battle_state

signal strategy_phase_started
signal combat_phase_started
signal resolve_phase_started

func _ready() -> void:
	print("started")

func set_battle_state_to_strategy():
	set_battle_state(battle_state.BATTLE_STRATEGY)
	
func set_battle_state_to_combat():
	set_battle_state(battle_state.BATTLE_COMBAT)
	
func set_battle_state_to_resolve():
	set_battle_state(battle_state.BATTLE_RESOLVE)

func set_battle_state(new_state: battle_state) -> void:
	current_state = new_state
	match current_state:
		battle_state.BATTLE_STRATEGY:
			print("strategy phase begin")
			strategy_phase_started.emit()
		battle_state.BATTLE_COMBAT:
			print("combat phase begin")
			combat_phase_started.emit()
		battle_state.BATTLE_RESOLVE:
			print("resolve phase begin")
			resolve_phase_started.emit()
