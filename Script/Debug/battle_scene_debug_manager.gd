class_name BattleSceneDebugManager
extends Node

@export var is_enable: bool = true
@export var scene_manager: BattleManager
@export var debug_view: BattleSceneDebugView

func _ready() -> void:
	if is_enable:
		debug_view.strategy_pressed.connect(_on_strategy)
		debug_view.combat_pressed.connect(_on_combat)
		debug_view.resolve_pressed.connect(_on_resolve)
	else:
		debug_view.visible = false


func _on_strategy():
	scene_manager.change_state_to_strategy()

func _on_combat():
	scene_manager.change_state_to_combat()

func _on_resolve():
	scene_manager.change_state_to_resolve()
