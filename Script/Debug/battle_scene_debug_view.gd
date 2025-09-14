class_name BattleSceneDebugView
extends Control

signal strategy_pressed
signal combat_pressed
signal resolve_pressed


func _on_strategy_pressed() -> void:
	strategy_pressed.emit()


func _on_combat_pressed() -> void:
	combat_pressed.emit()


func _on_resolve_pressed() -> void:
	resolve_pressed.emit()
