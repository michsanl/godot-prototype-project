class_name BattleSceneDebugManager
extends Node

@export var scene_manager: BattleManager
@export var debug_view: BattleSceneDebugView

func _ready() -> void:
	debug_view.strategy_pressed.connect(_on_strategy)
	debug_view.combat_pressed.connect(_on_combat)
	debug_view.resolve_pressed.connect(_on_resolve)


func _on_strategy():
	scene_manager.change_state_to_strategy()

func _on_combat():
	scene_manager.change_state_to_combat()

func _on_resolve():
	scene_manager.change_state_to_resolve()
